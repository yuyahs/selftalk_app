class Api::NoticesController < ApplicationController
  before_action :admined_user, only: [:create, :destroy]

  def index
    @notices = Notice.all
  end

  def show
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
  end

  private

  def notice_params
    params.require(:notice).permit(:title, :content)
  end



end
