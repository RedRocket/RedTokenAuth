require "rails_helper"

RSpec.describe RedTokenAuth::Configuration do
  let(:user) { build(:user, email: "valid@mail.com", password: "abcd1234", password_confirmation: "abcd1234", authentication_token: "token") }

  it "should authenticate the token" do
    expect(user.authenticate_token("token")).to eq(true)
    expect(user.authenticate_token("random")).to eq(false)
  end
end
