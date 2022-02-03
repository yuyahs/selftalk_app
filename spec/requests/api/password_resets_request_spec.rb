require 'rails_helper'

RSpec.describe "Api::PasswordResets", type: :request do
  let(:user) { create(:user) }
  before { user.create_reset_digest }

  describe "POST /create" do
    context "誤ったメールアドレスが入力された場合" do
      it "エラー400を返す" do
        post api_password_resets_path, params: {password_reset: {email: ""}}
        expect(response).to have_http_status "400"
      end
    end

    context "正しいメールアドレスが入力された場合" do
      it "レスポンス204を返す" do
        post api_password_resets_path, params: {password_reset: {email: user.email}}
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

    context "ユーザーが無効な場合" do
      it "エラー400を返す" do
        user.toggle!(:activated)
        patch api_password_reset_path(user.reset_token),
        params: {email: user.email,
                 user: {
                 password: "password",
                 password_confirmation: "password" }}
        expect(response).to have_http_status "400"
      end
    end

    context "メールアドレスが有効でトークンが無効な場合" do
      it "エラー400を返す" do
          patch api_password_reset_path('wrong token'),
          params: {email: user.email,
                   user: {
                   password: "password",
                   password_confirmation: "password" }}
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
          expect(response).to have_http_status "200"
      end
    end
  end

    describe "Securities test" do
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
        it "レスポンス200を返す" do
          patch api_password_reset_path(user.reset_token),
          params: {email: user.email,
                   user: {
                   password: "foobar",
                   password_confirmation: "foobar" }}
          expect(is_logged_in?).to be_truthy
          expect(user.reload.reset_digest).to eq nil
          expect(response).to have_http_status "200"
        end
      end
    end

    context "ログイン中の場合" do
      before do
        log_in_as user
      end

      describe "POST/ create" do
        it "root_pathにリダイレクトする" do
          post api_password_resets_path, params: {password_reset: {email: user.email}}
          expect(ActionMailer::Base.deliveries.size).to eq(0)
          expect(response).to redirect_to root_path
        end
      end

      describe "PATCH/ update" do
        it "root_pathにリダイレクトする" do
          patch api_password_reset_path(user.reset_token),
            params: {email: user.email,
                     user: {
                     password: "password",
                     password_confirmation: "password" }}
            expect(response).to redirect_to root_path
        end
      end
    end

    context "ゲストログイン中の場合" do
      before do
        guest_login
      end

      describe "POST/ create" do
        it "root_pathにリダイレクトする" do
          post api_password_resets_path, params: {password_reset: {email: user.email}}
          expect(ActionMailer::Base.deliveries.size).to eq(0)
          expect(response).to redirect_to root_path
        end
      end

      describe "PATCH/ update" do
        it "root_pathにリダイレクトする" do
          patch api_password_reset_path(user.reset_token),
            params: {email: user.email,
                     user: {
                     password: "password",
                     password_confirmation: "password" }}
            expect(response).to redirect_to root_path
        end
      end
    end
end
