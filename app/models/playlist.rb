class Playlist < ActiveRecord::Base
  validates :name, :presence => true
  has_many :playlist_elements
  has_many :songs, :through => :playlist_elements, :order => 'playlist_elements.order'

  def length
    self.songs.sum(:length)
  end
end
