require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  should_require_attributes :name
  
  should_have_many :memberships, :dependent => :destroy
  should_have_many :members, :through => :memberships
  should_have_many :reports, :dependent => :destroy
  
  context "with other projects" do
    setup do
      Factory(:project)
    end

    should_require_unique_attributes :api_token
  end
  
  should "create membership for owner" do
    @user = Factory(:user)
    @project = @user.projects.create!(:name => Factory.next(:project_name))
    @membership = @project.memberships.find(:first, :conditions => { :user_id => @user.id })
    assert ! @membership.nil?
    assert_equal 'owner', @membership.role
  end
  
end
