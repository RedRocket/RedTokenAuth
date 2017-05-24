module RedTokenAuth
  module Authentication
    extend ActiveSupport::Concern

    included do
      def authenticate_token(token)
        BCrypt::Password.new(authentication_token) == token
      end

      def create_new_authentication_token
        token        = SecureRandom.urlsafe_base64(nil, true)
        token_hash   = BCrypt::Password.create(token)

        self.authentication_token = token_hash

        save!

        {
          "access-token" => token,
          "uid"          => email,
          "token-type"   => "Bearer"
        }
      end
    end
  end
end
