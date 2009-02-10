require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should_validate_presence_of :name
  should_validate_presence_of :login
  should_validate_presence_of :email
  
  should_ensure_length_at_least :name, 2
  should_ensure_length_at_least :login, 2
  
  should_have_many :memberships, :dependent => :destroy
  should_have_many :projects, :through => :memberships
  
  context "with other user" do
    setup do
      Factory(:user)
    end
    
    should_validate_uniqueness_of :login
    should_validate_uniqueness_of :email
  end
  
end
