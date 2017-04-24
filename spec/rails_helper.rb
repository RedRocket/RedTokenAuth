# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'test'

require 'rails/all'

require 'rspec/rails'
require 'shoulda/matchers'

# system({"RAILS_ENV" => "test"}, "cd spec/rails_app ; bin/rails db:reset")

require 'test_app/config/environment'

require 'spec_helper'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end