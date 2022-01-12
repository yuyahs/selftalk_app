class Api::UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: [:update]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :not_guest_user, only: [:index, :show, :create, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = current_user
    @dates = current_user.answers.map{|dates| dates.created_at.to_date}.uniq
    @learning_days = @dates.count
    @sequential_days = sequential_days
    #MyPage.vueで曜日毎のanswerを取り出す際に~月~日の'月日'を弾くために（）を付けている
    @wdays = ['(月)','(火)','(水)','(木)','(金)','(土)','(日)']
    @contributions = current_user.answers.created_in_a_week
    @contributions = @contributions.map{|days| I18n.l(days.created_at)}
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
      response_success(:user, :update)
    else
      response_bad_request
    end
  end

  def destroy
    @user.destroy
    response_success(:user, :destroy)
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def set_user
    @user = @user || current_user
  end
end
