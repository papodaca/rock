class AlbumsController < ApplicationController
  def index
    @albums = []
    if params[:page].present?
      page = Integer(params[:page]) - 1
      count = Integer(APP_CONFIG['default_page_size'])
      if params[:count].present?
        count = Integer(params[:count])
      end
      @albums = Album.order(:title).limit(count).offset(page * count)
    else
      @albums = Album.find(:all)
    end
  end

  def pageCount
    count = Integer(APP_CONFIG['default_page_size'])
    if params[:count].present?
      count = Integer(params[:count])
    end
    render :text => (Float(Album.all.count) / Float(count)).ceil
  end

  def show
    @album = Album.find(params[:id])
  end
end
