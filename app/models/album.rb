class Album < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence=> true
  belongs_to :art
  belongs_to :artist
  has_many :songs


  def length
    Song.where(:album_id => self.id).sum(:length)
  end
end
