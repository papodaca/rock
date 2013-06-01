class AlbumsController < ApplicationController
  def index
    page, count = getPageValues()
    albums = Album.page(page).per_page(count)

    render :json => formPagenationResponce(albums, 'albums/index')
  end

  def show
    @album = Album.find(params[:id])
  end
end
