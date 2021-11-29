require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  let(:user){create(:user)}
  let(:other_user){create(:user)}

  #beforeアクションに引っかからないパターンのテスト
  describe "GET/ show" do
    it "成功レスポンス200を返す" do
      log_in_as user
      get api_user_path(user)
      expect(response).to have_http_status "200"
    end
  end

  describe "GET/ new" do
    it "成功レスポンス204を返す" do
      get new_api_user_path
      expect(response).to have_http_status "204"
    end
  end

  describe "POST/ create" do
    it "不正な入力情報に対してエラー400を返す" do
      post api_users_path, params:
      { user: { name:  "",
        email: "user@invalid",
        password: "foo",
        password_confirmation: "bar" } }
      expect(response).to have_http_status "400"
    end

    it "有効な入力情報に対しユーザーの保存に成功する" do
      expect{
        post api_users_path, params:
        { user: { name:  "example",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password" } }
        }.to change(User, :count).by(1)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      expect(response).to have_http_status "204"
    end

    context "既にログイン中の場合" do
      it "ユーザー作成に失敗し、エラー400を返す"do
        log_in_as user
        expect{
          post api_users_path, params: { user: { name:  "examaple2",
            email: "user2@example.com",
            password: "password",
            password_confirmation: "bpassword" } }
          }.to change(User, :count).by(0)
        expect(response).to have_http_status "400"
      end
    end
  end


  describe "GET/ edit" do
    context "ログイン済みユーザーのアクセス" do
      it "user.nameとuser.emailが入力済みのフォームを表示し、成功レスポンス200を返す" do
        log_in_as user
        get edit_api_user_path(user)
        expect(response.body).to include user.name
        expect(response.body).to include user.email
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "PATCH/ update" do
    context "ログイン済みユーザーのアクセス" do
      before do
        log_in_as user
      end

      it "passwordが空欄の時に成功レスポンス200を返す" do
        patch api_user_path(user), params: {user: {
            name: "Foo Bar",
            email: "foo@bar.com",
            password: "",
            password_confirmation: ""
        }}
        expect(response).to have_http_status "200"
      end

      it "不正なユーザー情報に対してレスポンス400を返す" do
        patch api_user_path(user), params: {user: {
            name: "",
            emai: "foo@invalid",
            password: "foo",
            password_confirmation: "bar"
        }}
        expect(response).to have_http_status "400"
      end
    end
  end

  describe "Delete/ destroy" do
    it "ユーザーが削除され、成功レスポンス200を返す" do
      log_in_as user
      expect{
        delete api_user_path(user), params: {id: user.id}
      }.to change(User, :count).by(-1)
      expect(response).to have_http_status "200"
    end
  end

  # logged_in_userのテスト [show,edit,update,destory]

  context "未ログインの場合" do
    describe "GET/ show" do
      it "login_pathにリダイレクトする" do
        get api_user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    describe "GET/ edit" do
      it "login_pathにリダイレクトする" do
        get edit_api_user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    describe "PATCH/ update" do
      it "login_pathにリダイレクトする" do
        patch api_user_path(user), params: {user: {
          name: "Foo Bar",
          email: "foo@bar.com",
          password: "",
          password_confirmation: ""
       }}
       expect(response).to redirect_to login_path
      end
    end
  end

  #correct_userのテスト [show,edit,update,destory]

  context "間違ったユーザーがアクセスした場合" do
    before do
      log_in_as other_user
    end

    describe "GET/ show" do
      it "root_pathにリダイレクトする" do
        get api_user_path(user)
        expect(response).to redirect_to root_path
      end
    end

    describe "GET/ edit" do
      it "root_pathにリダイレクトする" do
        get edit_api_user_path(user)
        expect(response).to redirect_to root_path
      end
    end

    describe "PATCH/ update" do
      it "root_pathにリダイレクトする" do
        patch api_user_path(user), params: {user: {
          name: "Foo Bar",
          email: "foo@bar.com",
          password: "",
          password_confirmation: ""
        }}
        expect(response).to redirect_to root_path
      end
    end

    describe "DELETE/ destroy" do
      it "root_pathにリダイレクトする" do
        delete api_user_path(user), params: {id: user.id}
        expect(response).to redirect_to root_path
      end
    end

  end

  #not_guest_userのテスト [show,new,create,edit,update,destory]

  context "ゲストログイン中の場合" do
    before do
      guest_login
    end

    describe "GET/ show" do
      it "root_pathにリダイレクトする" do
        get api_user_path(user)
        expect(response).to redirect_to root_path
      end
    end

    describe "GET/ new" do
      it "root_pathにリダイレクトする" do
        get new_api_user_path
        expect(response).to redirect_to root_path
      end
    end

    describe "POST/ create" do
      it "root_pathにリダイレクトする" do
        post api_users_path, params:
        { user: { name:  "example",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password" } }
        expect(response).to redirect_to root_path
      end
    end

    describe "GET/ edit" do
      it "root_pathにリダイレクトする" do
        get edit_api_user_path(user)
        expect(response).to redirect_to root_path
      end
    end

    describe "PATCH/ update" do
      it "root_pathにリダイレクトする" do
        patch api_user_path(user), params: {user: {
          name: "Foo Bar",
          email: "foo@bar.com",
          password: "",
          password_confirmation: ""} }
        expect(response).to redirect_to root_path
      end
    end

    describe "DELETE/ destroy" do
      it "root_pathにリダイレクトする" do
        delete api_user_path(user), params: {id: user.id}
        expect(response).to redirect_to root_path
      end
    end
  end
end
