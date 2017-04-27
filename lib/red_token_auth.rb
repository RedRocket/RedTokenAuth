require "red_token_auth/version"
require "red_token_auth/engine"

require "red_token_auth/configuration"

require "red_token_auth/sign_in_out"
require "red_token_auth/password"

module RedTokenAuth
  extend ActiveSupport::Concern

  class << self
    attr_writer :configuration
  end

  included do
    include SignInOut
    include Password
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
