class Playlist < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  has_many :songs, :through => :playlist_elements
end
