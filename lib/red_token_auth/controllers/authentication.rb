module Controllers
  module Authentication
    extend ActiveSupport::Concern

    class_methods do
      def authenticate(klass, options = {})
        klass = klass.to_s.capitalize.constatize
        auth_key = options[:auth_key] || :email
        auth_param = options[:auth_param] || :email

        @resource = klass.find_by(auth_key: headers[:"#{auth_param}"])

        if entity.authenticate_token(headers[:"#{klass.to_s.downcase}-#{auth_param}"])
          @resource
        else
          render_unauthorized
        end
      end
    end

    included do
      def render_unauthorized(errors)
        render head: :ok, status: :unauthorized
      end
    end
  end
end
