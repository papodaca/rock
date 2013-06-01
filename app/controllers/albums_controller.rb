class AlbumsController < ApplicationController
  def index
    page, count = getPageValues()
    albums = Album.page(page).per_page(count)
    if params[:artist_id].present?
      albums = albums.where(:artist_id => params[:artist_id])
    end

    render :json => formPagenationResponce(albums, 'albums/index')
  end

  def show
    @album = Album.find(params[:id])
  end
end
