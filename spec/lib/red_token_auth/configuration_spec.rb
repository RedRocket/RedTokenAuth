require "rails_helper"

RSpec.describe RedTokenAuth::Configuration do
  it "should initialize with default values" do
    expect(RedTokenAuth.configuration.email_regex).not_to be_nil
    expect(RedTokenAuth.configuration.password_length).not_to be_nil
  end

  context "configuration file" do
    before :each do
      RedTokenAuth.configure do |config|
        config.email_regex = /.@./
        config.password_length = 6..10
      end
    end

    it "should assign configurations" do
      expect(RedTokenAuth.configuration.email_regex).to eq(/.@./)
      expect(RedTokenAuth.configuration.password_length).to eq(6..10)
    end
  end
end
