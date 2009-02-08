require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase
  
  context "with some date" do
    current_user_is { Factory(:user) }
    
    setup do
      @user = current_user || Factory(:user)
      @project = @user.projects.create!(:name => Factory.next(:project_name))
      @errors = []
      @errors << Factory(:error, :project => @project) ; Factory(:occurence, :error => @errors.last)
      @errors << Factory(:error, :project => @project) ; Factory(:occurence, :error => @errors.last)
      @errors << Factory(:error, :project => @project) ; Factory(:occurence, :error => @errors.last)
    end
    
    context "on GET to :index" do
      setup { get :index }
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
    context "on GET to :show" do
      setup do
        @error = @errors[1]
        get :show, :id => @error.id
      end
      
      should_respond_with :success
      should_respond_with_content_type :html
      should_assign_to :error,   :class => Error,   :equals => '@error'
      should_render_template :show
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
  end
end
