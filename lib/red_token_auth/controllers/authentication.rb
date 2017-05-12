module Controllers
  module Authentication
    extend ActiveSupport::Concern

    class_methods do
      # class UserController < ApplicationController
      #   before_action only: [:index] { authenticate :user }
      # end
      def authenticate(resource, options = {})
        klass = resource.to_s.capitalize.constatize

        auth_key   = options[:auth_key]   || :email
        auth_param = options[:auth_param] || :email

        resource = klass.find_by(auth_key: headers[:"#{auth_param}"])

        unless entity.authenticate_token(headers[:"#{klass.to_s.downcase}-#{auth_param}"])
          render_unauthorized
        end
      end
    end

    included do
      def resource_name(klass)
        klass.to_s.downcase.to_sym
      end
    end

    private

    def generate_methods
      define_method(:"current_#{resource_name(klass)}") do
        resource
      end
    end
  end
end
