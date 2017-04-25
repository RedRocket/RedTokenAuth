require "securerandom"

module RedTokenAuth
  module Password
    extend ActiveSupport::Concern

    included do
      include ActiveModel::SecurePassword

      # Adds #password_confirmation and #authenticate.
      # The model must have a field named #password_digest.
      has_secure_password

      def generate_reset_password_token
        update(reset_password_token: random_token, reset_password_token_sent_at: Time.zone.now)
      end
    end
  end

  def random_token
    SecureRandom.hex(15)
  end
end
