class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre_new = Genre.new
  end

  def create
    @genre_new = Genre.new(genre_params)
    if @genre_new.save
      redirect_to admin_genres_path
      flash[:notice] = "ジャンル名を追加しました。"
    else
      @genres = Genre.all
      render :index
    end
  end

  def edit
  end

  def update
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
