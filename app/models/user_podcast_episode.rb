class UserPodcastEpisode < ActiveRecord::Base
  validates :location, :played, :presence => true
  belongs_to :user
  belongs_to :podcast_episode
end
