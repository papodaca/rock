class ArtistsController < ApplicationController
  def index
    page, count = getPageValues()
    artists = Artist.page(page).per_page(count)

    render :json => formPagenationResponce(artists, 'artists/index')
  end
end
