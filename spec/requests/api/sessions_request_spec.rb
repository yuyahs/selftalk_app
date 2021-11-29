require 'rails_helper'

RSpec.describe "Api::Sessions", type: :request do
  let(:user){create(:user)}
  let(:other_user){create(:user)}

  context "未ログインの場合" do

    describe "POST/ create" do
      it "不正な入力情報に対しログインに失敗し、エラー400を返す" do
        post api_login_path, params: { session: { email: "invalid@example.com",
        password: 'password' } }
        expect(response).to have_http_status "400"
      end

      it "有効な入力情報に対しログインに成功して、レスポンス200を返す" do
        post api_login_path, params: { session: { email: user.email,
        password: 'password' } }
        expect(response).to have_http_status "200"
      end

      it "ログイン後クッキーを保存する" do
        log_in_as user
        expect(cookies[:remember_token]).not_to eq nil
      end
    end

    describe "DELETE/ destroy" do
      it "ログアウトに失敗して、レスポンス400を返す" do
        delete api_logout_path
        expect(response).to have_http_status "400"
        expect(is_logged_in?).to be_falsy
      end
    end
  end

  context "ログイン中の場合" do

    before do
      log_in_as user
    end

    describe "POST/ create" do
      it "ログインに失敗し、エラー400を返す" do
        post api_login_path, params: { session: { email: other_user.email,
          password: 'password' } }
          expect(response).to have_http_status "400"
      end
    end

    describe "DELETE/ destroy" do
      it "ログアウトに成功して、レスポンス200を返す" do
        delete api_logout_path
        expect(response).to have_http_status "200"
        expect(is_logged_in?).to be_falsy
      end
    end
  end

  #not_guest_userのテスト [create]
  context "ゲストログイン中の場合" do
    describe "POST/ create" do
      it "root_pathにリダイレクトする" do
        guest_login
        post api_login_path, params: { session: { email: other_user.email,
          password: 'password' } }
        expect(response).to redirect_to root_path
      end
    end
  end
end
