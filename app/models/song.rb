class Song < ActiveRecord::Base
  validates :disk, :length, :title, :track, :presence => true
  belongs_to :album
  belongs_to :genre
  belongs_to :artist
  belongs_to :data_file
  belongs_to :library
end
