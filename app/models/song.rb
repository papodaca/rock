class Song < ActiveRecord::Base
  attr_accessible :disk, :length, :title, :track
  validates :disk, :length, :title, :track, :presence => true
  belongs_to :album
  belongs_to :genre
  belongs_to :artist
  belongs_to :data_file
end
