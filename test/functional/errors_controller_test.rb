require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase
  
  context "with some date" do
    setup do
      @user = Factory(:user)
      set_session_for @user
      @project = Factory(:project, :owner => @user)
      @errors = []
      @errors << Factory(:error, :project => @project) ; Factory(:occurence, :error => @errors.last)
      @errors << Factory(:error, :project => @project) ; Factory(:occurence, :error => @errors.last)
      @errors << Factory(:error, :project => @project) ; Factory(:occurence, :error => @errors.last)
    end
    
    context "on GET to :index" do
      setup { get :index, :project_id => @project.id }

      should_redirect_to "project_path(@project)"
    end
    
    context "on GET to :show" do
      setup do
        @error = @errors[1]
        get :show, :project_id => @project.id, :id => @error.id
      end
      
      should_respond_with :success
      should_respond_with_content_type :html
      should_assign_to :error,   :class => Error,   :equals => '@error'
      should_assign_to :project, :class => Project, :equals => '@project'
      should_render_template :show
    end
    
  end
end
