class SongsController < ApplicationController
  def index
    page, count = getPageValues()
    songs = []
    if params[:genre_id].present?
      songs = Song.page(page).per_page(count).where(:genre_id => params[:genre_id])
    else
      songs = Song.page(page).per_page(count)
    end

    render :json => formPagenationResponce(songs, 'songs/index')
  end

  def show
    @song = Song.find(params[:id])
  end

  def stream
    song = Song.find(params[:id])
    filePath = song.data_file.path
    mimeType = song.data_file.media_type.mime_type

    send_file filePath, :type => mimeType, :disposition => 'inline'
  end
end
