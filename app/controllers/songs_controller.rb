class SongsController < ApplicationController
  def index
    page, count = getPageValues()
    songs = Song.page(page).per_page(count)
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
      redirect_to getS3Url(song)
    else
      mimeType = song.data_file.media_type.mime_type

      send_file filePath, :type => mimeType, :disposition => 'inline'
    end
  end

  def isS3Bucket?(path)
    /[s,S]3:\/\/.+$/.match(path) != nil
  end

  def getS3Url(song)
    matches = /[s,S]3:\/\/([^\/]+)\/(.+)$/.match(song.data_file.path).captures
    bucket = matches[0]
    file = matches[1]

    captures = /[S,s]3:\/\/([^\s]+)\/([^\s]+)\ ([^\s]+)\ ([^\s]+)$/.match(song.library.data_file.path).captures

    connection = Fog::Storage.new(
      :provider => 'AWS',
      :aws_access_key_id => captures[2],
      :aws_secret_access_key => captures[3],
      :region => captures[0])

    connection.directories.get(bucket).files.get_https_url(file, Time.new.utc.to_i() + 60 * 60)
  end
end
