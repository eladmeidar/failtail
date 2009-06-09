class Notifier < ActionMailer::Base
  
  def invitation(invitation, sent_at = Time.now)
    subject    'You received a Failtale invitation!'
    recipients invitation.email
    from       'donotreply@failtale.be'
    sent_on    sent_at
    
    body       :invitation => invitation
  end
  
  def invitation_request(email, sent_at = Time.now)
    subject    'A new Failtale invitation!'
    recipients 'failtale@mrhenry.be'
    from       'donotreply@failtale.be'
    sent_on    sent_at
    
    body       :email => email
  end
  
  def occurence_report(user, occurence, sent_at = Time.now)
    subject    "[#{occurence.error.project.name}] An error occured (@#{occurence.error_id})"
    recipients user.email
    from       'donotreply@failtale.be'
    sent_on    sent_at
    
    body       :user => user, :occurence => occurence
  end

end
