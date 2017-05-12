require "securerandom"

module RedTokenAuth
  module SignInOut
    extend ActiveSupport::Concern

    included do
      def sign_in(password)
        if authenticate(password)
          update(authentication_token: random_token)
        else
          errors.add(:password, :wrong_password)
        end
      end

      def sign_out(auth_token)
        if auth_token == authentication_token
          update(authentication_token: nil)
        else
          errors.add(:authentication_token, :wrong_token)
          false
        end
      end
    end

    def random_token
      SecureRandom.hex(30)
    end
  end

end
