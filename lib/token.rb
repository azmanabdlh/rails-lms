
class Token
  attr_accessor :encryptor

  def initialize
    @encryptor = Concurrent::Map.new
  end


  class <<self
    def instance
      @instance ||= new
    end

    def encryptor_for(salt, len = 32)
      raise ArgumentError, "salt cannot be blank!" if salt.blank?

      instance.encryptor.compute_if_absent(salt) do
        key = Rails.application.key_generator.generate_key(salt, len)
        ActiveSupport::MessageEncryptor.new(key)
      end

      nil
    end


    def generate_for(salt, token)
      @@instance.encryptor[salt].encrypt_and_sign(token)
    end

    def verify_for?(salt, encrypted_token)
      decrypted = @@instance.encryptor[salt].decrypt_and_verify(encrypted_token)
      decrypted.present?
    rescue ActiveSupport::MessageEncryptor::InvalidMessage
      false
    end
  end
end
