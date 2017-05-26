module RedTokenAuth
  module OmniauthCallbacksAndValidations
    extend ActiveSupport::Concern

    included do
      validates :email, presence: true, email: true, if: Proc.new { |resource| resource.provider == "email" }
      validates_presence_of :uid, if: Proc.new { |resource| resource.provider != "email" }

      # only validate unique emails among email registration users
      validate :unique_email_user

      # Syncronize UID and email if provider is the user's email.
      before_save :syncronize_uid
    end

    protected

    def unique_email_user
      if provider == "email" && self.class.where(provider: "email", email: email).count > 0
        errors.add(:email, :taken)
      end
    end

    def syncronize_uid
      self.uid = email if provider == "email"
    end
  end
end
