class Library < ActiveRecord::Base
  attr_accessible :name, :data_file_id, :progress

  belongs_to :data_file
  has_many :songs
end
