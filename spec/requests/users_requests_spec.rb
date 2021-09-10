require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:user){create(:user)}
  let(:other_user){create(:user)}

  describe "show/ user_path" do

    before do
      log_in_as user
    end

    it "shows today and yesterday's records" do
      get user_path(user)
      expect(response.body).to include "学習記録"
    end


  end
  describe "post/ signup_path " do
    it "as an invalid user" do
      post users_path, params: { user: { name:  "",
                                  email: "user@invalid",
                                  password:              "foo",
                                  password_confirmation: "bar" } }
      expect(response).to_not have_http_status "302"
    end

    it "as a valid user" do
      expect{
        post users_path, params:
        { user: { name:  "example",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password" } }
        }.to change(User, :count).by(1)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      expect(response).to redirect_to root_url
      expect(is_logged_in?).to be_falsy
    end
  end

  describe "post/ login_path" do
    it "as an invalid user" do
      post login_path, params: { session: { email: "invalid@example.com",
      password: 'password' } }
      expect(response).to_not redirect_to user_path(user)
    end

    it "as a valid user" do
      post login_path, params: { session: { email: user.email,
      password: 'password' } }
      expect(response).to redirect_to root_path
    end

    it "remember me" do
      log_in_as user
      expect(cookies[:remember_token]).not_to eq nil
    end

    it "does not remembers the cookie when user does not checks the Remember Me box" do
      log_in_as(user, remember_me: '0')
      expect(cookies[:remember_token]).to eq nil
    end
  end
  describe "delete/ logout_path" do
    it "redirects to root_path" do
      post login_path ,params: { session: { email: user.email,
        password: 'password' } }
      delete logout_path
      expect(response).to redirect_to root_path
      expect(is_logged_in?).to be_falsy
    end
  end

  describe "get/ edit_user_path" do
    context "ログイン済みユーザーのアクセス" do
      it "redirects to edit_user_path" do
        log_in_as user
        get edit_user_path(user)
        expect(response.body).to include "登録情報を変更する"
      end
    end

    context "未ログインユーザーのアクセス" do
      it "returns to login_path" do
        get edit_user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    context "間違ったユーザーのアクセス" do
      it "redirects to root_path" do
        log_in_as user
        get edit_user_path(other_user)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "patch/ edit_user_path" do
    context "ログイン済みユーザーのアクセス" do
      before do
        log_in_as user
      end
      it "accepts valid information even if password is blank" do
        patch user_path(user), params: {user: {
            name: "Foo Bar",
            email: "foo@bar.com",
            password: "",
            password_confirmation: ""
        } }
        expect(response).to redirect_to root_path
      end

      it "rejects invalid information" do
        patch user_path(user), params: {user: {
            name: "",
            emai: "foo@invalid",
            password: "foo",
            password_confirmation: "bar"
        } }
        expect(response.body).to include "登録情報を変更する"
      end
    end
    context "未ログインユーザーのアクセス" do
      it "returns to login_path" do
        patch user_path(user), params: {user: {
          name: "Foo Bar",
          email: "foo@bar.com",
          password: "",
          password_confirmation: ""
      } }
      expect(response).to redirect_to login_path
      end
    end

    context "間違ったユーザーのアクセス" do
      it "redirects to root_path" do
        log_in_as user
        patch user_path(other_user), params: {user: {
          name: "Foo Bar",
          email: "foo@bar.com",
          password: "",
          password_confirmation: ""
        } }
      expect(response).to redirect_to root_path
      end
    end
  end

  describe "フレンドリーフォワーディング" do
    it "redirects to edit_user_path" do
      get edit_user_path(user)
      log_in_as user
      expect(response).to redirect_to edit_user_path(user)
    end
  end
end


