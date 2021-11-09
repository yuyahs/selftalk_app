class Api::GuestLoginsController < ApplicationController

  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end

    if log_in user
      response_success(:user, :guest_sign_in)
    end


  end

end
