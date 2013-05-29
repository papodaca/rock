class Artist < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  belongs_to :art
  has_many :song
  has_many :album
end
