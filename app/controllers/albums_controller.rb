class AlbumsController < ApplicationController
  def index
    page = params[:page].present? ? Integer(params[:page]) : 1
    count = params[:per_page].present? ? Integer(params[:per_page]) : Integer(APP_CONFIG['default_page_size'])
    albums = Album.page(page).per_page(count)

    render :json => formPagenationResponce(albums, 'albums/index')
  end

  def show
    @album = Album.find(params[:id])
  end
end
