class AlbumsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    page, count = getPageValues()
    albums = Album.page(page).per_page(count).order("name ASC")
    if params[:artist_id].present?
      albums = albums.where(:artist_id => params[:artist_id])
    end

    render :json => formPagenationResponce(albums, 'albums/index')
  end

  def show
    @album = Album.find(params[:id])
  end
end
