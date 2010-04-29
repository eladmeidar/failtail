class InvitationRequest < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email

  def create_invitation
    if Invitation.create(:email => self.email)
      self.destroy
    end
  end
end