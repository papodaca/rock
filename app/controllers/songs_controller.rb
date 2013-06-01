class SongsController < ApplicationController
  def index
    page, count = getPageValues()
    songs = Song.page(page).per_page(count)

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
