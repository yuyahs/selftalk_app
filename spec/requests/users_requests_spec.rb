require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:user){create(:user)}
  let(:other_user){create(:user)}

  # logged_in_userのテスト [show,edit,update,destory]

  context "未ログインの場合" do
    describe "GET/ show" do
      it "login_pathにリダイレクトする" do
        get user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    describe "GET/ edit" do
      it "login_pathにリダイレクトする" do
        get edit_user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    describe "PATCH/ update" do
      it "login_pathにリダイレクトする" do
        patch user_path(user), params: {user: {
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
        get user_path(user)
        expect(response).to redirect_to root_path
      end
    end

    describe "GET/ edit" do
      it "root_pathにリダイレクトする" do
        get edit_user_path(user)
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
        delete user_path(user), params: {id: user.id}
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
        get user_path(user)
        expect(response).to redirect_to root_path
      end
    end

    describe "GET/ new" do
      it "root_pathにリダイレクトする" do
        get new_user_path
        expect(response).to redirect_to root_path
      end
    end

    describe "POST/ create" do
      it "root_pathにリダイレクトする" do
        post users_path, params:
        { user: { name:  "example",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password" } }
        expect(response).to redirect_to root_path
      end
    end

    describe "GET/ edit" do
      it "root_pathにリダイレクトする" do
        get edit_user_path(user)
        expect(response).to redirect_to root_path
      end
    end

    describe "PATCH/ update" do
      it "root_pathにリダイレクトする" do
        patch user_path(user), params: {user: {
          name: "Foo Bar",
          email: "foo@bar.com",
          password: "",
          password_confirmation: ""} }
        expect(response).to redirect_to root_path
      end
    end

    describe "DELETE/ destroy" do
      it "root_pathにリダイレクトする" do
        delete user_path(user), params: {id: user.id}
        expect(response).to redirect_to root_path
      end
    end
  end
end


