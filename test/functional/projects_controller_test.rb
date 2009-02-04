require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  
  context "while logged in" do
    current_user_is { Factory(:user) }
    setup do
      @user = current_user || Factory(:user)
      @projects = [
        Factory(:membership, :user => @user).project,
        Factory(:membership, :user => @user, :role => 'owner').project
      ]
      Factory(:project)
    end
    
    context "on GET to :index" do
      setup { get :index }
      
      should_respond_with :success
      should_assign_to :projects, :equals => '@projects'
      should_render_template :index
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
    context "on GET to :show" do
      setup { get :show, :id => @projects[0].id }
      
      should_respond_with :success
      should_assign_to :project, :class => Project, :equals => '@projects.first'
      should_render_template :show
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
    context "on GET to :new" do
      setup { get :new }
      
      should_respond_with :success
      should_assign_to :project, :class => Project
      should_render_template :new
      should_render_a_form
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
    context "on GET to :edit" do
      setup { get :edit, :id => @projects.last.id }
      
      should_respond_with :success
      should_assign_to :project, :class => Project, :equals => '@projects.last'
      should_render_template :edit
      should_render_a_form
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
    context "on POST to :create" do
      context "wtth valid data" do
        setup { post :create, :project => Factory.attributes_for(:project) }
        
        should_change "@user.projects.count", :by => 1
        should_change "@user.memberships.count", :by => 1
        should_redirect_to "project_url(@project)"
      
        when_not_logged_in { should_redirect_to "home_url" }
      end
      
      context "wtth invalid data" do
        setup { post :create, :project => Factory.attributes_for(:project, :name => nil) }
        
        should_not_change "@user.projects.count"
        should_not_change "@user.memberships.count"
        should_respond_with :success
        should_assign_to :project, :class => Project
        should_render_template :new
        should_render_a_form
      
        when_not_logged_in { should_redirect_to "home_url" }
      end
    end
    
    context "on PUT to :update" do
      context "wtth valid data" do
        setup { put :update, :id => @projects.last.id,
          :project => Factory.attributes_for(:project) }
        
        should_not_change "@user.projects.count"
        should_not_change "@user.memberships.count"
        should_redirect_to "project_url(@projects.last)"
      
        when_not_logged_in { should_redirect_to "home_url" }
      end
      
      context "wtth invalid data" do
        setup { put :update, :id => @projects.last.id,
          :project => Factory.attributes_for(:project, :name => nil) }
        
        should_not_change "@user.projects.count"
        should_not_change "@user.memberships.count"
        should_respond_with :success
        should_assign_to :project, :class => Project, :equals => '@projects.last'
        should_render_template :edit
        should_render_a_form
      
        when_not_logged_in { should_redirect_to "home_url" }
      end
    end
    
    context "on DELETE to :destroy" do
      setup { delete :destroy, :id => @projects.last.id }
      
      should_change "@user.projects.count", :by => -1
      should_change "@user.memberships.count", :by => -1
      should_redirect_to "root_url"
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
  end
  
  context "require membership" do
    context "for :show" do
      setup do
        @user       = Factory(:user)
        @project    = Factory(:project)
        set_session_for @user
        get :show, :id => @project.id
      end
      
      should_redirect_to "root_path"
    end
  end
  
  context "require ownership" do
    context "for :edit" do
      setup do
        @user       = Factory(:user)
        @owner      = Factory(:user)
        @project    = Factory(:membership, :user => @owner, :role => 'owner').project
        set_session_for @user
        get :edit, :id => @project.id
      end
      
      should_redirect_to "root_path"
    end
    context "for :update" do
      setup do
        @user       = Factory(:user)
        @owner      = Factory(:user)
        @project    = Factory(:membership, :user => @owner, :role => 'owner').project
        set_session_for @user
        put :update, :id => @project.id, :project => { :name => "Cool Project" }
      end
      
      should_redirect_to "root_path"
    end
    context "for :destroy" do
      setup do
        @user       = Factory(:user)
        @owner      = Factory(:user)
        @project    = Factory(:membership, :user => @owner, :role => 'owner').project
        set_session_for @user
        delete :destroy, :id => @project.id
      end
      
      should_redirect_to "root_path"
    end
    
  end
  
end