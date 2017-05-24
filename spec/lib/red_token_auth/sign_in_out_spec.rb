require "rails_helper"

RSpec.describe RedTokenAuth::SignInOut do
  describe "#sign_in" do
    before :each do
      @user = create(:user, password: "abcd1234", password_confirmation: "abcd1234")
    end

    it "should be added to the model" do
      expect(User.new).to respond_to(:sign_in)
    end

    context "when password matches" do
      before :each do
        @user.sign_in("abcd1234")
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
    before :each do
      @user = create(:user, authentication_token: "AToken")
      @user.sign_out
    end
    
    it "should be added to the model" do
      expect(User.new).to respond_to(:sign_out)
    end

    it "should delete the current token" do
      expect(@user.authentication_token).to be_nil
    end
  end

end
