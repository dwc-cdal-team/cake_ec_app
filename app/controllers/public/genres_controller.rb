class Public::GenresController < ApplicationController

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @all_items = Item.where(genre_id: @genre.id)
    @items = Item.where(genre_id: @genre.id).page(params[:page]).per(8)
  end
end
