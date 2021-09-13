class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :not_guest_user, only: [:show, :edit, :update]

  def show
    @user = current_user
    @dates = current_user.answers.map{|dates| dates.created_at.to_date}.uniq
    @dates = Kaminari.paginate_array(@dates).page(params[:page]).per(5)

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:success] = "認証用メールを送信しました。ご確認ください。"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "登録情報を変更しました。"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  #before action


end
