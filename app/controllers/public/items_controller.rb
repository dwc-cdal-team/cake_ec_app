class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @all_items = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart = Cart.new
    @genres = Genre.all
  end
end
