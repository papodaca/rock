class Session < ActiveRecord::Base
  validates :user_id, :presence => true
  belongs_to :user

  def setKey
    self.session_key = SecureRandom.urlsafe_base64(170)
    self.save()
  end
end
