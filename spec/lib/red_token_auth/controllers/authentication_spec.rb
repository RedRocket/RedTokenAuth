require "rails_helper"

# Although the tested class is UsersController, we are actually testing
# `RedTokenAuth::Controllers::Authentication`.
# NOTE: If you do have a workaround this situation, it'll be appreciated.
RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, email: "valid@mail.com", password: "abcd1234", password_confirmation: "abcd1234", authentication_token: "token") }
  let(:sign_in_headers) { user.sign_in("abcd1234") }

  describe "#authenticate!" do
    context "success" do
      it "should authenticate" do
        request.headers.merge!(sign_in_headers)

        # This route needs authentication.
        get :show, params: { id: user.id }

        expect(response).to have_http_status(:ok)
      end
    end

    context "failure" do
      it "should render unauthorized" do
        request.headers.merge!(sign_in_headers)
        request.headers["access-token"] = "wrong_token"

        # This route needs authentication.
        get :show, params: { id: user.id }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "#current_user" do
    before :each do
      request.headers.merge!(sign_in_headers)
      # This route needs authentication.
      get :show, params: { id: user.id }
    end

    it "should be defined" do
      expect(@controller).to respond_to(:current_user)
    end

    it "should return the current resource"
  end
end
