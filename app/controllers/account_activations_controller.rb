class AccountActivationsController < ApplicationController

  #メールに組み込まれるurlに'api'が含まれると違和感があるのでeditだけ通常にcontrollerで処理する
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      redirect_to login_url
    else
      redirect_to root_url
    end
  end
end
