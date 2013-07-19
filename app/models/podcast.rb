class Podcast < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :data_file
  has_many :songs, :through => :podcast_episodes
end
