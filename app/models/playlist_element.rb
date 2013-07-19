class PlaylistElement < ActiveRecord::Base
  validates :order, :presence => true
  belongs_to :playlist
  belongs_to :song
end
