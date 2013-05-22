class Album < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence=> true
  belongs_to :art
  belongs_to :artist
end
