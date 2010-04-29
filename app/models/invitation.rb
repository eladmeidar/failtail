class Invitation < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email

  before_create :generate_code
  after_create :send_invitation

private

  def generate_code
    self.code = Digest::SHA1.hexdigest(self.email + Time.now.to_s + rand.to_s)
  end

  def send_invitation
    Notifier.deliver_invitation(self)
  end
end
