require 'rails_helper'

RSpec.describe "Api::GuestLogins", type: :request do

  describe "GET/ guest_sign_in" do

    it "成功レスポンス200を返す" do
      post "/api/guest_sign_in"
      expect(response).to have_http_status "200"
    end

    context "guest ログイン中にuser&answer controllerのアクションを実行しようとした場合" do
      let(:user){create(:user)}
      before do
        post "/api/guest_sign_in"
      end

      it "redirects to root url" do
        get api_user_path(user)
        expect(response).to redirect_to root_path
      end

      it "redirects to root url" do
        get "/api/answers"
        expect(response).to redirect_to root_path
      end
    end
  end

end
