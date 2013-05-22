class UserPodcastEpisode < ActiveRecord::Base
  attr_accessible :location, :played
  validates :location, :played, :presence => true
  belongs_to :user
  belongs_to :podcast_episode
end
