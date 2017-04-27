require "rails_helper"

RSpec.describe RedTokenAuth::Configuration do
  it "should initialize with default values" do
    expect(RedTokenAuth.configuration.email_regex).not_to be_nil
    expect(RedTokenAuth.configuration.password_regex).not_to be_nil
    expect(RedTokenAuth.configuration.password_length).not_to be_nil
  end
end
