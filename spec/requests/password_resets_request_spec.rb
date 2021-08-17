require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  let(:user) { create(:user) }
  before { user.create_reset_digest }
  describe "GET /new" do
    it "returns http success" do
      get new_password_reset_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "誤ったメールアドレスが入力された場合" do
      it "renders new" do
        post password_resets_path, params: {password_reset: {email: ""}}
        expect(response).to have_http_status(200)
        expect(response.body).to include "パスワード再設定用リンクを送信する"
      end
    end

    context "正しいメールアドレスが入力された場合" do
      it "redirects to root_path" do
        post password_resets_path, params: {password_reset: {email: user.email}}
        expect(ActionMailer::Base.deliveries.size).to eq(1)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET /edit" do
    context "メールアドレスが無効な場合" do
      it "redirects to root_path" do
        get edit_password_reset_path(user.reset_token, email: "")
        expect(response).to redirect_to root_path
      end
    end

    context "ユーザーが無効な場合" do
      it "redirects to root_path" do
        user.toggle!(:activated)
        get edit_password_reset_path(user.reset_token, email: user.email)
        expect(response).to redirect_to root_path
      end
    end

    context "メールアドレスが有効でトークンが無効な場合" do
      it "redirects to root_path" do
        get edit_password_reset_path('wrong token', email: user.email)
        expect(response).to redirect_to root_path
      end
    end

    context "メールアドレス・トークンが有効な場合" do
      it "redirects to root_path" do
        get edit_password_reset_path(user.reset_token, email: user.email)
        expect(response.body).to include "新しいパスワードを設定する"
      end
    end
  end

  describe "patch /update" do
    context "無効なパスワードとパスワード確認" do
      it "renders edit" do
        patch password_reset_path(user.reset_token),
        params: {email: user.email,
                user: {
                password: "foobaz",
                password_confirmation: "abcdefg" }}
        expect(response).to have_http_status(200)
        expect(response.body).to include "新しいパスワードを設定する"
      end
    end

    context "パスワードがからの場合" do
      it "renders edit" do
        patch password_reset_path(user.reset_token),
        params: {email: user.email,
                user: {
                password: "",
                password_confirmation: "" }}
        expect(response).to have_http_status(200)
        expect(response.body).to include "新しいパスワードを設定する"
      end
    end

    context "有効なパスワードとパスワード確認" do
      it "redirects to user" do
        patch password_reset_path(user.reset_token),
        params: {email: user.email,
                user: {
                password: "password",
                password_confirmation: "password" }}
        expect(is_logged_in?).to be_truthy
        expect(response).to redirect_to user
      end
    end
  end

  describe "Securities" do
    context "パスワード再設定の期限が切れた場合" do
      it "renders new" do
        user.update_attribute(:reset_sent_at, 3.hours.ago)
        patch password_reset_path(user.reset_token),
        params: {email: user.email,
                 user: {
                 password: "foobar",
                 password_confirmation: "foobar" }}
        expect(response).to redirect_to new_password_reset_path
      end
    end

    context "パスワード再設定後、ダイジェストがnilになる場合" do
      it "redirects to root_path" do
        patch password_reset_path(user.reset_token),
        params: {email: user.email,
                 user: {
                 password: "foobar",
                 password_confirmation: "foobar" }}
        expect(is_logged_in?).to be_truthy
        expect(user.reload.reset_digest).to eq nil
        expect(response).to redirect_to user
      end
    end


  end

end
