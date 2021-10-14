require 'rails_helper'

RSpec.describe "Api::AccountActivations", type: :request do
  let(:user) { create(:user, :no_activated) }

  context "トークンは有効だがメールアドレスが無効な場合" do
    before do
      get edit_api_account_activation_path(
        user.activation_token,
        email: 'wrong')
    end

    it "ログインに失敗し、エラー400を返す" do
      expect(is_logged_in?).to be_falsy
      expect(response).to  have_http_status "400"
    end
  end

  context "有効なトークンと有効なメールアドレスが送信された場合" do
   before do
     get edit_api_account_activation_path(
        user.activation_token,
        email: user.email,
      )
    end


    it "ログインに成功してルートURLにアクセスする" do
      expect(is_logged_in?).to be_truthy
      expect(response).to redirect_to root_path
    end
  end

end
