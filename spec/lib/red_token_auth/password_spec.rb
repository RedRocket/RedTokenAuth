require "rails_helper"

RSpec.describe RedTokenAuth::SignInOut do
  describe "#password" do
    it "should be added to the class" do
      expect(User.new).to respond_to(:password)
    end
  end

  describe "#password_confirmation" do
    it "should be added to the class" do
      expect(User.new).to respond_to(:password_confirmation)
    end
  end
end
