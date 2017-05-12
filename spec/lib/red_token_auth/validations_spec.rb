require "rails_helper"

RSpec.describe RedTokenAuth::Configuration do
  let(:invalid_user) { build(:user, email: "invalidmail.com", password: "abcd", password_confirmation: "abcd") }
  let(:valid_user) { build(:user, email: "valid@mail.com", password: "abcd1234", password_confirmation: "abcd1234") }

  it "should save a valid user" do
    expect(valid_user.save).to eq(true)
  end

  it "should validate #email" do
    expect { invalid_user.save }.to change { invalid_user.errors[:email] }
  end

  it "should validate #password" do
    expect { invalid_user.save }.to change { invalid_user.errors[:password] }
  end

  it "should validate #password only if #password.present?" do
    user = build :user, password: ""
    puts user.errors.full_messages.join ","
    expect(user.valid?).to eq(true)
  end

  it "should add a readable error message to email field"
  it "should add a readable error message to password field"
end
