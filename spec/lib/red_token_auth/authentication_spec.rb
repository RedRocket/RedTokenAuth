require "rails_helper"

RSpec.describe RedTokenAuth::Configuration do
  let(:user) { create(:user, email: "valid@mail.com", password: "abcd1234", password_confirmation: "abcd1234", authentication_token: "token") }
  let(:sign_in) { user.sign_in("abcd1234") }

  describe "#authenticate_token" do
    it "should authenticate the token" do
      headers = sign_in
      expect(user.authenticate_token(headers["access-token"])).to eq(true)
      expect(user.authenticate_token("random")).to eq(false)
    end
  end

  describe "create_new_authentication_token" do
    it "should create a new token" do
      expect { user.create_new_authentication_token }
        .to change { user.reload.authentication_token }
    end

    it "should return a hash" do
      expect(user.create_new_authentication_token).to be_a(Hash)
    end

    it "should return values necessary for further authentication" do
      expect(user.create_new_authentication_token).to have_key("access-token")
      expect(user.create_new_authentication_token).to have_key("uid")
    end
  end
end
