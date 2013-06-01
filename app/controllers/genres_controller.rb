class GenresController < ApplicationController
  def index
    page, count = getPageValues()
    genres = Genre.page(page).per_page(count).joins(:songs).uniq

    @genres = genres
  end
end
