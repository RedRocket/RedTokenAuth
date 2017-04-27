require "securerandom"

module RedTokenAuth
  module Password
    extend ActiveSupport::Concern

    included do
      include ActiveModel::SecurePassword

      # Attribute for updating password.
      # Entity must pass current password in order to change its password.
      attr_accessor :current_password

      # Adds #password_confirmation and #authenticate.
      # The model must have a field named #password_digest.
      has_secure_password

      def generate_reset_password_token
        update(reset_password_token: random_token, reset_password_token_sent_at: Time.zone.now)
      end

      def update_password(params = {})
        if authenticate(params[:current_password]) && !params[:current_password].blank?
          update(password: params[:password], password_confirmation: params[:password_confirmation])
        else
          #HACK: It would be nicer if this logic was inside a validation.
          #TODO: Add message yml.
          errors.add(:current_password, :wrong_password)
          return false
        end
      end

      def reset_password(params = {})
        if params[:reset_password_token] == reset_password_token
          update(password: params[:password], password_confirmation: params[:password_confirmation], reset_password_token_sent_at: nil)
        else
          #HACK: It would be nicer if this logic was inside a validation.
          #TODO: Add message yml.
          errors.add(:current_password, :wrong_reset_password_token)
          return false
        end
      end
    end

    def random_token
      SecureRandom.hex(3)
    end
  end
end
