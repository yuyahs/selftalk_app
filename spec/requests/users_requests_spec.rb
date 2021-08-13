require 'rails_helper'

RSpec.describe "Users", type: :request do
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
      expect(response).to have_http_status "302"
    end
  end

  describe "post/ login_path" do
    before do
      @user = create(:user)
    end
      it "as an invalid user" do
        post login_path, params: { session: { email: "invalid@example.com",
        password: 'password' } }
        expect(response).to_not redirect_to user_path(@user)
      end

      it "as a valid user" do
        post login_path, params: { session: { email: @user.email,
        password: 'password' } }
        expect(response).to redirect_to user_path(@user)
      end

      it "remember me" do
        log_in_as @user
        expect(cookies[:remember_token]).not_to eq nil
      end

      it "does not remembers the cookie when user does not checks the Remember Me box" do
        log_in_as(@user, remember_me: '0')
        expect(cookies[:remember_token]).to eq nil
      end
  end
end


