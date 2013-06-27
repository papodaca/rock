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
      redirect_to getS3Url(filePath)
    else
      mimeType = song.data_file.media_type.mime_type

      send_file filePath, :type => mimeType, :disposition => 'inline'
    end
  end

  def isS3Bucket?(path)
    /[s,S]3:\/\/.+$/.match(path) != nil
  end

  def getS3Url(path)
    matches = /[s,S]3:\/\/([^\/]+)\/(.+)$/.match(path).captures
    bucket = matches[0]
    file = matches[1]

    connection = Fog::Storage.new(
      :provider => 'AWS', 
      :aws_access_key_id => APP_CONFIG['s3_key'], 
      :aws_secret_access_key => APP_CONFIG['s3_secret'], 
      :region => 'us-west-2')

    connection.directories.get(bucket).files.get_https_url(file, Time.new.utc.to_i() + 60 * 60)
  end
end
