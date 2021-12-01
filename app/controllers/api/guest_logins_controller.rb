class Api::GuestLoginsController < ApplicationController

  #ゲストログイン機能
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
    end

    #通常ログイン時にエラーを発する
    if !logged_in?
      log_in user
      response_success(:user, :guest_sign_in)
    else
      response_bad_request
    end
  end
end
