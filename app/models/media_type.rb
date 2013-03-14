class MediaType < ActiveRecord::Base
  attr_accessible :extension, :type
  validates :extension, :type, :presence => true
  has_many :data_file
end
