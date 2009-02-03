require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  
  context "when invitations are enabled" do
    
    setup do
      FAILTALE[:allow_invitations] = true
    end
    
    current_user_is { Factory(:user) }
    
    context "on GET to :new" do
      setup { get :new }
      
      should_respond_with :success
      should_render_a_form
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
    context "on POST to :create" do
      setup { post :create, :invitation => Factory.attributes_for(:invitation) }
      
      should_redirect_to "root_url"
      
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
  end
  
  context "when invitations are disabled" do
    
    setup do
      FAILTALE[:allow_invitations] = false
    end
    
    current_user_is { Factory(:user) }
    
    context "on GET to :new" do
      setup { get :new }
      should_redirect_to "root_url"
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
    context "on POST to :create" do
      setup { post :create, :invitation => Factory.attributes_for(:invitation) }
      should_redirect_to "root_url"
      when_not_logged_in { should_redirect_to "home_url" }
    end
    
  end
  
end
