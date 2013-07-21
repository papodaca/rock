class GenresController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    page, count = getPageValues()
    genres = Genre.page(page).per_page(count).joins(:songs).uniq

    @genres = genres
  end
end
