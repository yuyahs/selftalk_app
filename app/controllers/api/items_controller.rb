class Api::ItemsController < ApplicationController
  before_action :set_user, only: [:index, :create, :destroy]
  before_action :logged_in_user, only: [:index, :create, :destroy]
  before_action :not_guest_user, only: [:index, :create, :destroy]

  #items一覧表示機能
  def index
    @items = @user.items.all
  end

  #items作成機能
  def create
    @item = @user.items.new(item_params)
    if @item.save
      response_success(:item, :create)
    else
      response_bad_request
    end
  end

  #items削除機能
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
