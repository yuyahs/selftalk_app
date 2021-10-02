class Api::UsersController < ApplicationController

 def show
    @user = User.find(params[:id])
 end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      # flash[:success] = "認証用メールを送信しました。ご確認ください。"
      # redirect_to root_url

    else
      render json: @user.errors, status: :unprpcessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
