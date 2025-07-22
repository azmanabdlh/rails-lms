class LoginController < ApplicationController
  allow_unauthenticated_access only: %i[ perform ]

  def perform
    if user = User.authenticate_by(params.permit(:email, :password))
      token = start_new_token_for(user)
      render json: { message: "Successfully", token: token }
    else
      render json: { message: "Try another email address or password." }
    end
  end
end
