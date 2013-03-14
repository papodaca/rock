class PodcastEpisode < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :song
  belongs_to :podcast
end
