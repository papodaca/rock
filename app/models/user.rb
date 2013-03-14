class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_hash, :password_salt
  validates :email, :name, :password_hash, :password_salt, :presence => true
  belongs_to :role
  has_many :user_podcast_episodes
  has_many :podcasts, :through => :user_podcast_subscriptions
end
