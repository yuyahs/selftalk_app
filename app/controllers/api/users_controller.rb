class Api::UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
    else
      response_bad_request
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      # flash[:success] = "登録情報を変更しました。"
      # redirect_to root_url
    else
      response_bad_request
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
