module RedTokenAuth
  module Omniauthable
    module CallbacksAndValidations
      extend ActiveSupport::Concern

      included do
        validates :email, presence: true, if: Proc.new { |resource| resource.provider == "email" }
        validates_presence_of :uid, if: Proc.new { |resource| resource.provider != "email" }

        # Only validate unique emails among email registered users.
        validate :unique_email_user

        # Syncronize UID and email if provider is the user's email.
        before_save :syncronize_uid
      end

      protected

      def unique_email_user
        if provider == "email" && email_changed? && self.class.where(provider: "email", email: email).count > 0
          errors.add(:email, :taken)
        end
      end

      def syncronize_uid
        self.uid = email if provider == "email"
      end
    end
  end
end
