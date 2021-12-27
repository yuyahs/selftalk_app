class Api::NoticesController < ApplicationController
  before_action :admined_user, only: [:create, :destroy]

  def index
    @notices = Notice.all
  end

  def show
    @notice = Notice.find_by(id: params[:id])
  end

  def create
    @notice = Notice.new(notice_params)
    if @notice.save
      response_success(:notice, :create)
    else
      response_bad_request
    end
  end

  def destroy
    Notice.find(params[:id]).destroy
    response_success(:notice, :destroy)
  end

  private

  def notice_params
    params.require(:notice).permit(:title, :content)
  end



end
