class GenresController < ApplicationController
  def index
    page, count = getPageValues()
    genres = Genre.page(page).per_page(count).joins(:songs).uniq

    render :json => formPagenationResponce(genres, 'genres/index')
  end

  def show
    @genre = Genre.find(params[:id])
  end
end
