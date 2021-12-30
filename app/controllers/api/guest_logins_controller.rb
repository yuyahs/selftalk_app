class Api::GuestLoginsController < ApplicationController

  def guest_sign_in
    @guest_user = User.find_or_create_by!(email: 'guest@example.com') do |guest_user|
      guest_user.name = "ゲストユーザー"
      guest_user.password = SecureRandom.urlsafe_base64
    end

    if !logged_in?
      log_in @guest_user
      response_success(:user, :guest_sign_in)
    else
      response_bad_request
    end
  end
end
