require "rails_helper"

RSpec.describe RedTokenAuth::Omniauthable::CallbacksAndValidations do
  it "should update UID if the user's provider is email" do
    @user = build(:omniauth_user, email: "valid@email.com", password: "abcd1234", password_confirmation: "abcd1234")
    @user.provider = "email"
    @user.save

    expect { @user.update(email: "another_email@email.com") }
      .to change { @user.uid }
      .from("valid@email.com")
      .to("another_email@email.com")
  end

  it "should not create if email is already taken" do
    @user         = create(:omniauth_user, email: "valid@email.com", password: "abcd1234", password_confirmation: "abcd1234")
    @another_user = build(:omniauth_user, email: "valid@email.com", password: "abcd1234", password_confirmation: "abcd1234")

    expect { @another_user.save }
      .to change { @another_user.errors[:email] }
  end

  it "should not update if email is already taken" do
    @user         = create(:omniauth_user, email: "valid@email.com", password: "abcd1234", password_confirmation: "abcd1234")
    @another_user = create(:omniauth_user, email: "valid.2@email.com", password: "abcd1234", password_confirmation: "abcd1234")

    expect { @another_user.update(email: @user.email) }
      .to change { @another_user.errors[:email] }
  end

  it "should not validate the users email format if the provider isn't email" do
    @user = build(:omniauth_user, email: "valid@email.com", password: "abcd1234", password_confirmation: "abcd1234")
    @user.provider = "not_email"
    @user.email    = ""
    @user.uid      = "unique_id"

    expect(@user.valid?).to eq(true)
  end
end
