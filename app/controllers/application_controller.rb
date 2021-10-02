class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper


  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理ユーザーかどうか確認
  def admined_user
    if !logged_in?
      store_location
      redirect_to login_url
    elsif !current_user.admin?
      redirect_to root_url
    end
  end

  #ゲストユーザーかどうか確認
  def not_guest_user
    if guest_user?
      redirect_to root_url
    end
  end

end
