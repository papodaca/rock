class Playlist < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  has_many :playlist_elements
  has_many :songs, :through => :playlist_elements, :order => 'playlist_elements.order'
end
