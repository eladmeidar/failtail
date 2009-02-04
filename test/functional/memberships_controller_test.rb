require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase
  
  context "when owner" do
    
    current_user_is { Factory(:user) }
    
    context "on GET to :new" do
      setup do
        @project = Factory(:membership, :user => (current_user || Factory(:user)), :role => 'owner').project
        get :new, :project_id => @project.id
      end
      
      should_respond_with :success
      should_render_a_form
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
    context "on POST to :create" do
      setup do
        @project = Factory(:membership, :user => (current_user || Factory(:user)), :role => 'owner').project
        params   = { :email => Factory(:user).email }
        post :create, :project_id => @project.id, :membership => params
      end
      
      should_redirect_to "project_url(@project)"
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
  end
  
  context "when member" do
    
    current_user_is { Factory(:user) }
    
    context "on GET to :new" do
      setup do
        @project = Factory(:membership, :user => Factory(:user), :role => 'owner').project
        Factory(:membership, :project => @project, :user => current_user) if current_user
        get :new, :project_id => @project.id
      end
      
      should_redirect_to "project_url(@project)"
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
    context "on POST to :create" do
      setup do
        @project = Factory(:membership, :user => Factory(:user), :role => 'owner').project
        Factory(:membership, :project => @project, :user => current_user) if current_user
        params   = { :email => Factory(:user).email }
        post :create, :project_id => @project.id, :membership => params
      end
      
      should_redirect_to "project_url(@project)"
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
  end
  
end
