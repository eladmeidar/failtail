require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  
  context "on Send invitation" do
    setup do
      @invitation = Factory(:invitation)
      @email      = Notifier.create_invitation(@invitation)
    end
    
    should_have_subject 'You received a Failtale invitation!'
    should_have_to_recipient { @invitation.email }
    should_have_from 'donotreply@failtale.be'
    should_match_body('invitation url') { "http://www.failtale.be/users/new?invitation=#{@invitation.code}" }
  end
  
end
