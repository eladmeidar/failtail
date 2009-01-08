require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  
  should_require_attributes :project_id
  should_require_attributes :user_id
  
  should_require_unique_attributes :user_id, :scoped_to => :project_id
  
  should_belong_to :project
  should_belong_to :user
  
end
