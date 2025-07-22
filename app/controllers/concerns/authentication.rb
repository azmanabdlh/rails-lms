module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  def authenticated?
    Current.session.present?
  end

  def start_new_token_for(user)
    device_id = request.headers["X-DEVICE-ID"]

    session = Session.find_or_create_by(device_id: device_id, user: user) do |s|
      s.ip_address = request.remote_ip
      s.user_agent = resolve_user_agent
    end

    Token.generate_for("access token", session.token_digest)
  end

  def require_authentication
    resume_session || raise_request_authentication
  end

  def resume_session
    Current.session ||= perform_authenticate_token
  end

  def raise_request_authentication
    render json: { message: "Please login to perform this action" }, status: :unauthorized
  end

  def perform_authenticate_token
    token = resolve_token.to_s
    Session.find_by(token_digest: token) if token.present?
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def resolve_user_agent
    user_agent = request.headers["X-USER-AGENT"] if request.headers["X-USER-AGENT"].present?
    user_agent || request.user_agent
  end


  def resolve_token
    token = request.headers["Authorization"]&.split&.last
    Token.decrypt_for("access token", token)
  end
end
