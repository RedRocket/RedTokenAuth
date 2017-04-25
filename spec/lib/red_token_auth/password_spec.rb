require "rails_helper"

RSpec.describe RedTokenAuth::Password do
  before :each do
    @user = create(:user)
  end

  describe "#password" do
    it "should be added to the class" do
      expect(@user).to respond_to(:password)
    end
  end

  describe "#password_confirmation" do
    it "should be added to the class" do
      expect(@user).to respond_to(:password_confirmation)
    end
  end

  describe "#reset_password_token" do
    it "should be added to the class" do
      expect(@user).to respond_to(:reset_password_token)
    end
  end

  describe "#reset_password_token_sent_at" do
    it "should be added to the class" do
      expect(@user).to respond_to(:reset_password_token_sent_at)
    end
  end

  describe "#generate_reset_password_token" do
    before :each do
      @user.generate_reset_password_token
    end

    it "should be added to the class" do
      expect(@user).to respond_to(:generate_reset_password_token)
    end

    it "should generate a token" do
      expect(@user.reset_password_token).not_to be_nil
    end

    it "should update #reset_password_token_sent_at" do
      expect { @user.generate_reset_password_token }.to change { @user.reset_password_token_sent_at }
    end
  end
end
