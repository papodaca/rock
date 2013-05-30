class SongsController < ApplicationController
  def index
    @songs = []
    if params[:page].present?
      page = Integer(params[:page]) - 1
      count = Integer(APP_CONFIG['default_page_size'])
      if params[:count].present?
        count = Integer(params[:count])
      end
      @songs = Song.order(:title).limit(count).offset(page * count)
    else
      @songs = Song.find(:all)
    end
  end

  def pageCount
    count = Integer(APP_CONFIG['default_page_size'])
    if params[:count].present?
      count = Integer(params[:count])
    end
    render :text => (Float(Song.all.count) / Float(count)).ceil
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
