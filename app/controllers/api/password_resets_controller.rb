class Api::PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:update]
  before_action :valid_user, only: [:update]
  before_action :check_expiration, only: [:update]
  before_action :not_logged_in, only: [:create, :update]
  before_action :not_guest_user, only: [:create, :update]

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
    else
      response_bad_request
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      response_bad_request
    elsif @user.update(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      render json: { id: @user.id }
    else
      response_bad_request
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    #before action

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        response_bad_request
      end
    end

    # トークンが期限切れかどうか確認する
    def check_expiration
      if @user.password_reset_expired?
        response_bad_request
      end
    end
end
