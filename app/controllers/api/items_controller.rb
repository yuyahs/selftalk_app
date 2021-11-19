class Api::ItemsController < ApplicationController
  before_action :set_user, only: [:index, :create, :destroy]
  before_action :logged_in_user
  before_action :not_guest_user, only: [:index, :create, :destroy]

  def index
    @items = @user.items.all
    render json: @items
  end

  def create
    @item = @user.items.new(item_params)
    if @item.save
      response_success(:item, :create)
    else
      response_bad_request
    end
  end

  def destroy
    @item = @user.items.find(params[:id])
    @item.destroy
    response_success(:item, :destroy)
  end

  private

  def item_params
    params.require(:item).permit(:content, :meaning, :memo)
  end

  def set_user
    @user = @user || current_user
  end

end
