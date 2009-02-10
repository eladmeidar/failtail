require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  
  should_validate_presence_of :email
  
  context "with other invitations" do
    setup do
      Factory(:invitation)
    end
    
    should_validate_uniqueness_of :email
  end
  
  
end
