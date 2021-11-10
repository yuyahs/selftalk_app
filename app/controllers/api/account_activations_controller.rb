class Api::AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      redirect_to login_path
    else
      redirect_to root_path

    end
  end
end
