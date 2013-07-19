class User < ActiveRecord::Base
  validates :email, :name, :presence => true
  belongs_to :role
  has_many :user_podcast_episodes
  has_many :podcasts, :through => :user_podcast_subscriptions

  def setPassword(raw_password)
    self.password_salt = SecureRandom.urlsafe_base64(64)
    self.password_hash = self.generateHash(raw_password)
    self.save()
  end

  def auth(raw_password)
    self.generateHash(raw_password) == self.password_hash
  end

  def generateHash(raw_password)
    hash = ""
    for i in 1..100
      hash = (Digest::SHA2.new << (raw_password + self.password_salt + hash)).to_s
    end
    return hash
  end
end
