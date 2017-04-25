require "rails_helper"

RSpec.describe RedTokenAuth::Password do
  before :each do
    @user = create(:user, password: "123456789", password_confirmation: "123456789")
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

  describe "#update_password" do
    context "when the right current_password is used" do
      it "should update the user password" do
        expect do
          @user.update_password(current_password: "123456789",
                                password: "987654321",
                                password_confirmation: "987654321")
        end.to change { @user.password_digest }
      end
    end

    context "when the wrong current_password is used" do
      let(:update_wrong_password) do
        @user.update_password(current_password: "wring_password",
                              password: "987654321",
                              password_confirmation: "987654321")
      end

      it "should not update the user password" do
        expect { update_wrong_password }.not_to change { @user.password_digest }
      end

      it "should add errors to the entity instance" do
        expect { update_wrong_password }.to change { @user.errors[:current_password] }
      end
    end

    context "when the no current_password is used" do
      let(:update_wrong_password) do
        @user.update_password(current_password: "",
                              password: "987654321",
                              password_confirmation: "987654321")
      end

      it "should not update the user password" do
        expect { update_wrong_password }.not_to change { @user.password_digest }
      end

      it "should add errors to the entity instance" do
        expect { update_wrong_password }.to change { @user.errors[:current_password] }
      end
    end
  end

  describe "#reset_password" do
    before :each do
      @user.generate_reset_password_token
    end

    context "when the right token is used" do
      let(:reset_password) do
        @user.reset_password(reset_password_token: @user.reset_password_token,
                             password: "987654321",
                             password_confirmation: "987654321")
      end

      it "should change the entity's password" do
        expect { reset_password }.to change { @user.password_digest }
      end
    end

    context "when the wrong token is used" do
      let(:reset_password) do
        @user.reset_password(reset_password_token: "wrong_token",
                             password: "987654321",
                             password_confirmation: "987654321")
      end

      it "should not change the entity's password" do
        expect { reset_password }.not_to change { @user.password_digest }
      end

      it "should not update the user password" do
        expect { reset_password }.not_to change { @user.password_digest }
      end

      it "should add errors to the entity instance" do
        expect { reset_password }.to change { @user.errors[:current_password] }
      end
    end

    context "when no token is used" do
      let(:reset_password) do
        @user.reset_password(reset_password_token: "",
                             password: "987654321",
                             password_confirmation: "987654321")
      end

      it "should not change the entity's password" do
        expect { reset_password }.not_to change { @user.password_digest }
      end

      it "should not update the user password" do
        expect { reset_password }.not_to change { @user.password_digest }
      end

      it "should add errors to the entity instance" do
        expect { reset_password }.to change { @user.errors[:current_password] }
      end
    end
  end
end
