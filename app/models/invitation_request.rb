class InvitationRequest
  attr_accessor :email
  
  def new_record?
    true
  end
  
  def initialize(params={})
    @email = params.delete(:email)
  end

  def save
    Notifier.deliver_invitation_request(@email)
    true
  end
end
