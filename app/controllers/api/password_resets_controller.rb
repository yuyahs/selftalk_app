class Api::PasswordResetsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      # flash[:success] = "パスワード再設定用のメールを送信しました。"
      # redirect_to root_url
    else
      # flash[:danger] = "未登録のメールアドレスです。"
      # render 'new'
      response_bad_request
    end
  end


  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      response_bad_request
    elsif @user.update(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      # flash[:success] = "パスワードを再設定しました。"
      # redirect_to root_url
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
          # flash[:danger] = "Password reset has expired."
          response_bad_request
        end
      end
end
