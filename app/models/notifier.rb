class Notifier < ActionMailer::Base
  
  def invitation(invitation, sent_at = Time.now)
    subject    'You received a Failtale invitation!'
    recipients invitation.email
    from       'donotreply@failtale.be'
    sent_on    sent_at
    
    body       :invitation => invitation
  end

end
