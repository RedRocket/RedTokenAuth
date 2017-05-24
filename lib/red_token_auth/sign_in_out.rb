require "securerandom"

module RedTokenAuth
  module SignInOut
    extend ActiveSupport::Concern

    included do
      def sign_in(password)
        if authenticate(password)
          create_new_authentication_token
        else
          errors.add(:password, :wrong_password)
          false
        end
      end

      def sign_out
        update(authentication_token: nil)
      end
    end

    def random_token
      SecureRandom.hex
    end
  end

end
