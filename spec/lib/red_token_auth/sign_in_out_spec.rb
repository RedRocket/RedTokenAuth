require "rails_helper"

RSpec.describe RedTokenAuth::SignInOut do
  describe "#sign_in" do
    before :each do
      @user = create(:user, password: "123456789", password_confirmation: "123456789")
    end

    it "should be added to the model" do
      expect(User.new).to respond_to(:sign_in)
    end

    context "when password matches" do
      before :each do
        @user.sign_in("123456789")
      end

      it "should create a new token for the user" do
        expect(@user.authentication_token).not_to be_nil
      end
    end

    context "when password doesn't match" do
      before :each do
        @user.sign_in("wrong_password.eh")
      end

      it "should not create a new token for the user" do
        expect(@user.authentication_token).to be_nil
      end

      it "should add errors to the password field" do
        expect(@user.errors[:password]).not_to be_empty
      end
    end
  end

  describe "#sign_out" do
    it "should be added to the model" do
      expect(User.new).to respond_to(:sign_out)
    end

    context "when the right token is used" do
      before :each do
        @user = create(:user, authentication_token: "AToken")
        @user.sign_out(@user.authentication_token)
      end

      it "should delete the current token" do
        expect(@user.authentication_token).to be_nil
      end
    end

    context "when the wrong token is used" do
      before :each do
        @user = create(:user, authentication_token: "AToken")
        @user.sign_out("WR0ngT0k3n")
      end

      it "should not delete the current token" do
        expect(@user.authentication_token).not_to be_nil
      end

      it "should add errors to the authentication_token field" do
        expect(@user.errors[:authentication_token]).not_to be_empty
      end
    end
  end
end
