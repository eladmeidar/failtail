require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  
  context "on GET to :new" do
    context "when logged in" do
      setup do
        @user = Factory(:user)
        set_session_for @user
        get :new
      end
      
      should_redirect_to "account_url"
    end
    
    context "when not logged in" do
      setup { get :new }
      
      should_respond_with :success
      should_render_template :new
      should_render_a_form
    end
  end
  
  context "on POST to :create" do
    context "when not logged in" do
      context "with correct credentials" do
        setup do
          @user = Factory(:user)
          post :create, :user_session => { :login => @user.login, :password => "aaabbb" }
          @user_session = UserSession.find
        end
        
        should "find user session" do
          assert @user_session
        end
        
        should "have correct user" do
          assert_equal @user.id, @user_session.user.id
        end
        
        should_redirect_to "root_path"
      end
      context "with incorrect credentials" do
        setup do
          @user = Factory(:user)
          post :create, :user_session => { :login => @user.login, :password => "aaagg" }
          @user_session = UserSession.find
        end
        
        should_respond_with :success
        should_render_template "user_sessions/new.html.haml"
        should_render_a_form
      end
      
    end
    context "when logged in" do
      setup do
        @user = Factory(:user)
        set_session_for @user
        post :create, :user_session => { :login => @user.login, :password => "aaabbb" }
      end
      
      should_redirect_to "account_url"
    end
  end
  
  context "on DELETE to :destroy" do
    context "when logged in" do
      setup do
        @user = Factory(:user)
        set_session_for @user
        delete :destroy
      end
      
      should "not find user session" do
        assert_nil UserSession.find
      end
      
      should_redirect_to "new_user_session_path"
    end
    context "when not logged in" do
      setup do
        delete :destroy
      end
      
      should_redirect_to "home_url"
    end
  end
  
end
