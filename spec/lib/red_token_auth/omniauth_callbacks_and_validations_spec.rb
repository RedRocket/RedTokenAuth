require "rails_helper"

RSpec.describe RedTokenAuth::OmniauthCallbacksAndValidations do
  let(:user) { create(:user, email: "valid@mail.com", password: "abcd1234", password_confirmation: "abcd1234", authentication_token: "token") }

  it "should update UID if the user's provider is email" do
    user.provider = email

    expect { user.update(email: "another_email@email.com") }
      .to change { user.uid }
      .from("valid@email.com")
      .to("another_email@email.com")
  end
end
