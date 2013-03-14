class Role < ActiveRecord::Base
  attr_accessible :level, :name
  validates :level, :name, :presence => true
end
