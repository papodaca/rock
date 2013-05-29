class Art < ActiveRecord::Base
  attr_accessible :data_file_id
  belongs_to :data_file
end