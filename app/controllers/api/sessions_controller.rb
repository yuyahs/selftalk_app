class Api::SessionsController < ApplicationController
  before_action :not_logged_in, only: [:create]

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password]) && !logged_in?
      if @user.activated?
        log_in @user
        remember(@user)
        render json: { id: @user.id }
      else
        #flash messageでアカウントが有効化されていないことを表示するための分岐
        response_unauthorized
      end
    else
      response_bad_request
    end
  end

  def destroy
    if logged_in?
      log_out
      response_success(:user, :destroy)
    else
      response_bad_request
    end
  end
end
