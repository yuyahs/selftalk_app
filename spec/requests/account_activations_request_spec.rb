require 'rails_helper'

RSpec.describe "AccountActivations", type: :request do
  let(:user) { create(:user, :no_activated) }

  context "トークンは有効だがメールアドレスが無効な場合" do

    before do
      get edit_account_activation_path(
        user.activation_token,
        email: 'wrong')
    end

    it "ログイン時にエラー401を返す" do
      expect(response).to redirect_to root_path
      post api_login_path, params: { session: { email: user.email,
      password: 'password' } }
      expect(response).to have_http_status "401"
    end
  end

  context "有効なトークンと有効なメールアドレスが送信された場合" do

   before do
     get edit_account_activation_path(
        user.activation_token,
        email: user.email,
      )
    end

    it "ログイン画面に遷移し、レスポンス200を返す" do
      expect(response).to redirect_to login_path
      post api_login_path, params: { session: { email: user.email,
        password: 'password' } }
        expect(response).to have_http_status "200"
    end
  end

end
