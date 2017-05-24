module RedTokenAuth
  module Controllers
    module Authentication
      extend ActiveSupport::Concern


      included do
        # class UserController < ApplicationController
        #   before_action only: [:index] { authenticate! :user }
        # end
        def authenticate!(resource, options = {})
          klass = resource.to_s.capitalize.constantize

          #TODO: make this query configurable.
          @resource = klass.where(email: request.headers["uid"]).first

          unless @resource && @resource.authenticate_token(request.headers["access-token"])
            render_unauthorized
          end

          define_methods(klass)
        end

        def resource_name(klass)
          klass.to_s.downcase.to_sym
        end

        def render_unauthorized
          render json: I18n.t("red_token_auth.messages.unauthorized"), status: :unauthorized
        end
      end

      private

      def define_methods(klass)
        define_singleton_method(:"current_#{resource_name(klass)}") do
          @resource
        end
      end
    end
  end
end
