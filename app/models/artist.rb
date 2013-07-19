class Artist < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :art
  has_many :songs
  has_many :albums
end
