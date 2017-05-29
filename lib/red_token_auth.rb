require "red_token_auth/version"
require "red_token_auth/engine"

require "red_token_auth/configuration"

require "red_token_auth/authentication"
require "red_token_auth/sign_in_out"
require "red_token_auth/omniauthable"
require "red_token_auth/password"
require "red_token_auth/validations"


require "red_token_auth/controllers/authentication"

module RedTokenAuth
  extend ActiveSupport::Concern

  class << self
    attr_writer :configuration
  end

  included do
    include Authentication
    include SignInOut
    include Password
    include Validations
    include Omniauthable
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
