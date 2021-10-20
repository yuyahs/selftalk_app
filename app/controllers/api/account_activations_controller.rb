class Api::AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash.now[:success] = "SelfTalkEnglishへようこそ！"
      redirect_to root_path
    else
      flash.now[:danger] = "無効なリンクです。"
      redirect_to root_path

    end
  end
end
