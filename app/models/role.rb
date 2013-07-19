class Role < ActiveRecord::Base
  validates :level, :name, :presence => true
  has_many :users
end
