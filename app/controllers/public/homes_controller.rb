class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(created_at: :desc).limit(10)
    @genres = Genre.all
  end

  def about


  end
end
