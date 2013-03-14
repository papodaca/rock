class DataFile < ActiveRecord::Base
  attr_accessible :path
  validates :path, :presence => true
  belongs_to :media_type
end
