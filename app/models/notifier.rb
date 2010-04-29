class Notifier < ActionMailer::Base
  
  def invitation(invitation, sent_at = Time.now)
    subject    'You received a Failtale invitation!'
    recipients invitation.email
    from       'robot@failtale.be'
    sent_on    sent_at
    
    body       :invitation => invitation
  end
  
  def invitation_request(email, sent_at = Time.now)
    subject    'A new Failtale invitation!'
    recipients 'robot@failtale.be'
    from       'robot@failtale.be'
    sent_on    sent_at
    
    body       :email => email
  end
  
  def occurence_report(user, occurence, sent_at = Time.now)
    subject    "[#{occurence.error.project.name}] An error occured (@#{occurence.error_id})"
    recipients user.email
    from       'robot@failtale.be'
    sent_on    sent_at
    
    body       :user => user, :occurence => occurence
  end
  
  def password_reset_instructions(user, sent_at = Time.now)
    subject     "Failtale password reset instructions"
    recipients  user.email
    from        'yves@mrhenry.be'
    sent_on     sent_at
    
    body        :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

end
