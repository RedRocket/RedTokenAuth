# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'test'

require 'rails/all'

require 'rspec/rails'

# system({"RAILS_ENV" => "test"}, "cd spec/rails_app ; bin/rails db:reset")

require 'test_app/config/environment'

require 'mongoid-rspec'

require 'spec_helper'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Mongoid::Matchers, type: :model
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  # Database cleanup for MongoDB
  config.before(:suite) do
    DatabaseCleaner.orm = "mongoid"
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

end
