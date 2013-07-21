class ArtistsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    page, count = getPageValues()
    artists = Artist.page(page).per_page(count)

    render :json => formPagenationResponce(artists, 'artists/index')
  end
end
