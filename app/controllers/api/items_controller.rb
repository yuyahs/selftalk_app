class Api::ItemsController < ApplicationController
  before_action :set_user, only: [:index, :create]

  def index
    @items = @user.items.all
    render json: @items
  end

  def new
  end

  def create
    @item = @user.items.new(item_params)
    if @item.save
      response_success(:item, :create)
    end
  end

  private

  def item_params
    params.require(:item).permit(:content, :meaning, :memo)
  end

  def set_user
    @user = current_user
  end
  
end
