require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do

  # let(:user) { create(:user) }
  # before { user.create_reset_digest }

  # describe "GET /new" do
  #   it "returns http success" do
  #     get new_password_reset_path
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /edit" do
  #   context "メールアドレスが無効な場合" do
  #     it "redirects to root_path" do
  #       get edit_password_reset_path(user.reset_token, email: "")
  #       expect(response).to redirect_to root_path
  #     end
  #   end

  #   context "ユーザーが無効な場合" do
  #     it "redirects to root_path" do
  #       user.toggle!(:activated)
  #       get edit_password_reset_path(user.reset_token, email: user.email)
  #       expect(response).to redirect_to root_path
  #     end
  #   end

  #   context "メールアドレスが有効でトークンが無効な場合" do
  #     it "redirects to root_path" do
  #       get edit_password_reset_path('wrong token', email: user.email)
  #       expect(response).to redirect_to root_path
  #     end
  #   end

  #   context "メールアドレス・トークンが有効な場合" do
  #     it "redirects to root_path" do
  #       get edit_password_reset_path(user.reset_token, email: user.email)
  #       expect(response).to have_http_status(:success)
  #     end
  #   end
  # end

  # context "ログイン中の場合" do
  #   before do
  #     log_in_as user
  #   end

  #   describe "GET/ new" do
  #     it "root_pathにリダイレクトする" do
  #       get new_password_reset_path
  #       expect(response).to redirect_to root_path
  #     end
  #   end

  #   describe "GET/ edit" do
  #     it "root_pathにリダイレクトする" do
  #         get edit_password_reset_path(user.reset_token, email: user.email)
  #         expect(response).to redirect_to root_path
  #     end
  #   end
  # end

  # context "ゲストログイン中の場合" do
  #   before do
  #     guest_login
  #   end

  #   describe "GET/ new" do
  #     it "root_pathにリダイレクトする" do
  #       get new_password_reset_path
  #       expect(response).to redirect_to root_path
  #     end
  #   end

  #   describe "GET/ edit" do
  #     it "root_pathにリダイレクトする" do
  #         get edit_password_reset_path(user.reset_token, email: user.email)
  #         expect(response).to redirect_to root_path
  #     end
  #   end
  # end
end
