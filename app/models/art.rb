class Art < ActiveRecord::Base
  belongs_to :data_file
  has_one :album
  has_one :artist
end