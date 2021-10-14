require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  let(:user){create(:user)}
  let(:other_user){create(:user)}

  describe "post/ signup_path " do
    it "不正な入力情報に対してエラー400を返す" do
      post '/api/users', params: { user: { name:  "",
                                  email: "user@invalid",
                                  password:              "foo",
                                  password_confirmation: "bar" } }
      expect(response).to have_http_status "400"
    end

    it "有効な入力情報に対しユーザーの保存に成功する" do
      expect{
        post '/api/users', params:
        { user: { name:  "example",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password" } }
        }.to change(User, :count).by(1)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      expect(response).to have_http_status "204"

    end
  end

  
  # describe "get/ edit_user_path" do
  #   context "ログイン済みユーザーのアクセス" do
  #     it "redirects to edit_user_path" do
  #       log_in_as user
  #       get edit_user_path(user)
  #       expect(response.body).to include "登録情報を変更する"
  #     end
  #   end

  #   context "未ログインユーザーのアクセス" do
  #     it "returns to login_path" do
  #       get edit_user_path(user)
  #       expect(response).to redirect_to login_path
  #     end
  #   end

  #   context "間違ったユーザーのアクセス" do
  #     it "redirects to root_path" do
  #       log_in_as user
  #       get edit_user_path(other_user)
  #       expect(response).to redirect_to root_path
  #     end
  #   end
  # end

  # describe "patch/ edit_user_path" do
  #   context "ログイン済みユーザーのアクセス" do
  #     before do
  #       log_in_as user
  #     end
  #     it "accepts valid information even if password is blank" do
  #       patch user_path(user), params: {user: {
  #           name: "Foo Bar",
  #           email: "foo@bar.com",
  #           password: "",
  #           password_confirmation: ""
  #       } }
  #       expect(response).to redirect_to root_path
  #     end

  #     it "rejects invalid information" do
  #       patch user_path(user), params: {user: {
  #           name: "",
  #           emai: "foo@invalid",
  #           password: "foo",
  #           password_confirmation: "bar"
  #       } }
  #       expect(response.body).to include "登録情報を変更する"
  #     end
  #   end
  #   context "未ログインユーザーのアクセス" do
  #     it "returns to login_path" do
  #       patch user_path(user), params: {user: {
  #         name: "Foo Bar",
  #         email: "foo@bar.com",
  #         password: "",
  #         password_confirmation: ""
  #     } }
  #     expect(response).to redirect_to login_path
  #     end
  #   end

  #   context "間違ったユーザーのアクセス" do
  #     it "redirects to root_path" do
  #       log_in_as user
  #       patch user_path(other_user), params: {user: {
  #         name: "Foo Bar",
  #         email: "foo@bar.com",
  #         password: "",
  #         password_confirmation: ""
  #       } }
  #     expect(response).to redirect_to root_path
  #     end
  #   end
  # end

end
