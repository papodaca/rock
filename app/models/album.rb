class Album < ActiveRecord::Base
  validates :name, :presence=> true
  belongs_to :art
  belongs_to :artist
  has_many :songs

  def length
    self.songs.sum(:length)
  end
end
