class Library < ActiveRecord::Base
  belongs_to :data_file
  has_many :songs
end
