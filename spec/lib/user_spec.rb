require "rails_helper"

RSpec.describe User, type: :model do
  context "validations" do
    it { is_expected.to validate_confirmation_of(:password) }
  end
end
