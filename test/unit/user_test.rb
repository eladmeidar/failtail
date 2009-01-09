require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should_require_attributes :name
  should_require_attributes :login
  should_require_attributes :email
  
  should_ensure_length_at_least :name, 2
  should_ensure_length_at_least :login, 2
  
  should_have_many :owned_projects, :dependent => :destroy
  should_have_many :memberships, :dependent => :destroy
  should_have_many :projects, :through => :memberships
  
  context "with other user" do
    setup do
      Factory(:user)
    end
    
    should_require_unique_attributes :login
    should_require_unique_attributes :email
  end
  
end
