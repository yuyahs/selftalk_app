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


  describe "get/ edit_user_path" do
    context "ログイン済みユーザーのアクセス" do
      it "user.nameとuser.emailが入力済みのフォームを表示する" do
        log_in_as user
        get edit_api_user_path(user)
        expect(response.body).to include user.name
        expect(response.body).to include user.email
      end
    end
    context "未ログインユーザーのアクセス" do
      it "login_pathに飛ばされる" do
        get edit_api_user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    context "間違ったユーザーのアクセス" do
      it "root_pathに飛ばされる" do
        log_in_as user
        get edit_api_user_path(other_user)
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
          patch api_user_path(user), params: {user: {
              name: "Foo Bar",
              email: "foo@bar.com",
              password: "",
              password_confirmation: ""
          } }
          expect(response).to have_http_status "204"
        end

        it "rejects invalid information" do
          patch api_user_path(user), params: {user: {
              name: "",
              emai: "foo@invalid",
              password: "foo",
              password_confirmation: "bar"
          } }
          expect(response).to have_http_status "400"
        end
      end
      context "未ログインユーザーのアクセス" do
        it "returns to login_path" do
          patch api_user_path(user), params: {user: {
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
          patch api_user_path(other_user), params: {user: {
            name: "Foo Bar",
            email: "foo@bar.com",
            password: "",
            password_confirmation: ""
          } }
          expect(response).to redirect_to root_path
         end
      end
    end



end
