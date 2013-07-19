class MediaType < ActiveRecord::Base
  validates :extension, :mime_type, :presence => true
  has_many :data_file
end
