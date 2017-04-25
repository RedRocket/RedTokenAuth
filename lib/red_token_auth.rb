require "red_token_auth/version"
require "red_token_auth/engine"

require "red_token_auth/sign_in_out"
require "red_token_auth/password"

module RedTokenAuth
  extend ActiveSupport::Concern

  included do
    include SignInOut
    include Password
  end
end
