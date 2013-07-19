class DataFile < ActiveRecord::Base
  validates :path, :presence => true
  belongs_to :media_type
end
