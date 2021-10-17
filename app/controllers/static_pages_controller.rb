class StaticPagesController < ApplicationController

  include SessionsHelper

  def home
    @user = current_user
  end

  def about
  end

  def contact
  end

  def policy
  end

  # 以下を追加
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end

    if log_in user
      flash[:success] = 'ゲストユーザーとしてログインしました。'
      redirect_to root_path
    end


  end

end
