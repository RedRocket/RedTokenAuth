require "securerandom"

module RedTokenAuth
  module Validations
    extend ActiveSupport::Concern

    included do
      include ActiveModel::SecurePassword

      validates :email,
        format: RedTokenAuth.configuration.email_regex,
        if: Proc.new { |resource| resource.email.present? || resource.provider == "email" }
      validates :password,
        format: RedTokenAuth.configuration.password_regex,
        length: { in: RedTokenAuth.configuration.password_length },
        confirmation: true,
        if: Proc.new { |resource| resource.password.present? }
    end
  end
end
