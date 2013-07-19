class PodcastEpisode < ActiveRecord::Base
  belongs_to :song
  belongs_to :podcast
end
