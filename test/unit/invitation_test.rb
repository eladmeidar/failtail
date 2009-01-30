require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  
  should_require_attributes :email
  
  context "with other invitations" do
    setup do
      Factory(:invitation)
    end
    
    should_require_unique_attributes :email
  end
  
  
end
