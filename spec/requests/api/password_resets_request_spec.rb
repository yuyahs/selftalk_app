require 'rails_helper'

RSpec.describe "Api::PasswordResets", type: :request do
  let(:user) { create(:user) }
  before { user.create_reset_digest }

  describe "POST /create" do
    context "誤ったメールアドレスが入力された場合" do
      it "エラー400を返す" do
        post '/api/password_resets', params: {password_reset: {email: ""}}
        expect(response).to have_http_status "400"

      end
    end

    context "正しいメールアドレスが入力された場合" do
      it "レスポンス204を返す" do
        post '/api/password_resets', params: {password_reset: {email: user.email}}
        expect(ActionMailer::Base.deliveries.size).to eq(1)
        expect(response).to have_http_status "204"
      end
    end
  end

  describe "patch /update" do
   context "無効なパスワードとパスワード確認" do
     it "エラー400を返す" do
        patch api_password_reset_path(user.reset_token),
          params: {email: user.email,
                  user: {
                  password: "foobaz",
                  password_confirmation: "abcdefg" }}
          expect(response).to have_http_status "400"

      end
    end

    context "パスワードが空の場合" do
      it "エラー400を返す" do
        patch api_password_reset_path(user.reset_token),
          params: {email: user.email,
                   user: {
                   password: "",
                   password_confirmation: "" }}
          expect(response).to have_http_status "400"

      end
    end

    context "有効なパスワードとパスワード確認" do
      it "レスポンス204を返す" do
        patch api_password_reset_path(user.reset_token),
          params: {email: user.email,
                   user: {
                   password: "password",
                   password_confirmation: "password" }}
          expect(is_logged_in?).to be_truthy
          expect(response).to have_http_status "204"
      end
    end
  end



    describe "Securities" do
      context "パスワード再設定の期限が切れた場合" do
        it "エラー400を返す" do
          user.update_attribute(:reset_sent_at, 3.hours.ago)
          patch api_password_reset_path(user.reset_token),
          params: {email: user.email,
                   user: {
                   password: "foobar",
                   password_confirmation: "foobar" }}
          expect(response).to have_http_status "400"
        end
      end

      context "パスワード再設定後、ダイジェストがnilになる場合" do
        it "レスポンス204を返す" do
          patch api_password_reset_path(user.reset_token),
          params: {email: user.email,
                   user: {
                   password: "foobar",
                   password_confirmation: "foobar" }}
          expect(is_logged_in?).to be_truthy
          expect(user.reload.reset_digest).to eq nil
          expect(response).to have_http_status "204"
        end
      end
    end



end
