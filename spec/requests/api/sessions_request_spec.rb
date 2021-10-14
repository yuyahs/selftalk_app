require 'rails_helper'

RSpec.describe "Api::Sessions", type: :request do
  let(:user){create(:user)}
  
  describe "post/ login_path" do
    it "不正な入力情報に対しログインに失敗する" do
      post '/api/login', params: { session: { email: "invalid@example.com",
      password: 'password' } }
      expect(response).to have_http_status "400"
    end

    it "有効な入力情報に対しログインに成功する" do
      post '/api/login', params: { session: { email: user.email,
      password: 'password' } }
      expect(response).to have_http_status "204"
    end

    it "ログイン後クッキーを保存する" do
      log_in_as user
      expect(cookies[:remember_token]).not_to eq nil
    end

  end



  describe "delete/ logout_path" do
    it "ログアウトに成功する" do
      post '/api/login' ,params: { session: { email: user.email,
        password: 'password' } }
      delete '/api/logout'
      expect(response).to have_http_status "204"
      expect(is_logged_in?).to be_falsy
    end
  end


end
