class SongsController < ApplicationController
  include AwsHelper

  def index
    page, count = getPageValues()
    songs = Song.page(page).per_page(count).order("title ASC")
    if params[:genre_id].present?
      songs = songs.where(:genre_id => params[:genre_id])
    elsif params[:artist_id].present?
        songs = songs.where(:artist_id => params[:artist_id])
    end

    render :json => formPagenationResponce(songs, 'songs/index')
  end

  def show
    @song = Song.find(params[:id])
  end

  def stream
    song = Song.find(params[:id])
    filePath = song.data_file.path

    if isS3Bucket?(filePath)
      redirect_to getS3Url(song.data_file.path, song.library.data_file.path)
    else
      mimeType = song.data_file.media_type.mime_type

      send_file filePath, :type => mimeType, :disposition => 'inline'
    end
  end
end
