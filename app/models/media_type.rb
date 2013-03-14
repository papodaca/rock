class MediaType < ActiveRecord::Base
  attr_accessible :extension, :mime_type
  validates :extension, :mime_type, :presence => true
  has_many :data_file
end
