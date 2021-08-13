require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "post/ signup_path " do
    it "doesn't work with invalid information" do
      post users_path, params: { user: { name:  "",
                                  email: "user@invalid",
                                  password:              "foo",
                                  password_confirmation: "bar" } }
      expect(response).to_not have_http_status "302"
    end

    it "works with valid information" do
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
    it "doesn't work with invalid information " do
      @user = create(:user)
      post login_path, params: { session: { email: "invalid@example.com",
      password: 'password' } }
      expect(response).to_not redirect_to user_path(@user)
    end
    
    it "works with valid information" do
      @user = create(:user)
      post login_path, params: { session: { email: @user.email,
      password: 'password' } }
      expect(response).to redirect_to user_path(@user)
    end
  end
end


