class Api::GuestLoginsController < ApplicationController

  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
    end

    if !logged_in?
      log_in user
      response_success(:user, :guest_sign_in)
    else
      response_bad_request
    end
  end
end
