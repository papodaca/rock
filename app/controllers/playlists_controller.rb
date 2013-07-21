class PlaylistsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index 
    @playlists = Playlist.all
  end

  def show
    @playlist = Playlist.find(params[:id])
  end
end
