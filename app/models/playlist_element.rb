class PlaylistElement < ActiveRecord::Base
  attr_accessible :order, :playlis_id, :song_id
  validates :order, :presence => true
  belongs_to :playlist
  belongs_to :song
end
