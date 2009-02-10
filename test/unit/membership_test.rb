require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  
  should_validate_presence_of :project_id
  should_validate_presence_of :user_id
  should_validate_presence_of :role
  
  should_belong_to :project
  should_belong_to :user
  
  should_have_index :user_id
  should_have_index :project_id
  
  context "with other memberships" do
    setup do
      Factory(:membership)
    end
    
    should_validate_uniqueness_of :user_id, :scoped_to => :project_id
  end
  
end
