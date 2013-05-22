class PlaylistElement < ActiveRecord::Base
  attr_accessible :order
  validates :order, :presence => true
  belongs_to :playlist
  belongs_to :song
end
