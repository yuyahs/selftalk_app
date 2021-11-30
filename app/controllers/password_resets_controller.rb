class PasswordResetsController < ApplicationController
  before_action :not_logged_in, only: [:new, :edit]
  before_action :not_guest_user, only: [:new, :edit]
  before_action :valid_user, only: [:edit]

  def new
  end

  def create
  end


  def edit
  end

  def update
  end

  #before action

   # 正しいユーザーかどうか確認する
   def valid_user
    @user = User.find_by(email: params[:email])
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
      redirect_to root_path
    end
  end
end
