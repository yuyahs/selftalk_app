class Api::UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :not_guest_user, only: [:show, :edit, :update]

  def index
  end

  def show
    @user = current_user
    @dates = current_user.answers.map{|dates| dates.created_at.to_date}.uniq
    @learning_days = @dates.count
    # @wdays = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun']
    @wdays = ['(月)','(火)','(水)','(木)','(金)','(土)','(日)']
    @contributions = current_user.answers.where(created_at: Time.current.all_week)
    @contributions = @contributions.map{|days| I18n.l(days.created_at)}
    # @contributions = @contributions.map{|d| d.strftime('%a')}
    # @contributions = @contributions.map{|days| days.created_at.strftime("%Y/%m/%d(#{I18n.t('date.abbr_day_names')[date.wday]})")}


  end

  def new
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
    @user = User.find(params[:id])
  end
end
