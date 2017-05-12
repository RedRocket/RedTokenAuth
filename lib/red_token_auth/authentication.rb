module RedTokenAuth
  module Authentication
    extend ActiveSupport::Concern

    included do
      def authenticate_token(token)
        token == authentication_token
      end
    end
  end
end
