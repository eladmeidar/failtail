require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  setup do
    FAILTALE[:allow_registration] = true
  end
  
  context "on GET to :show" do
    context "when logged in" do
      setup do
        @user = Factory(:user)
        set_session_for @user
        get :show, :id => @user.id
      end
      
      should_respond_with :success
      should_render_template :show
    end
    context "when not logged in" do
      setup do
        @user = Factory(:user)
        get :show, :id => @user.id
      end
      
      should_redirect_to "home_url"
    end
  end
  
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
      setup do
        @user = Factory(:user)
        get :new
      end
      
      should_respond_with :success
      should_render_template :new
      should_render_a_form
    end
  end
  
  context "on GET to :edit" do
    context "when logged in" do
      setup do
        @user = Factory(:user)
        set_session_for @user
        get :edit, :id => @user.id
      end
      
      should_respond_with :success
      should_render_template :edit
      should_render_a_form
    end
    context "when not logged in" do
      setup do
        @user = Factory(:user)
        get :edit, :id => @user.id
      end
      
      should_redirect_to "home_url"
    end
  end
  
  context "on POST to :create" do
    context "when logged in" do
      setup do
        @user = Factory(:user)
        set_session_for @user
        post :create, :user => Factory.attributes_for(:user, :login => "mr-henry")
      end
      
      should_redirect_to "account_url"
    end
    context "when not logged in" do
      context "and sends invalid data" do
        setup do
          @user = Factory(:user)
          post :create, :user => { :login => "" }
        end
      
        should_respond_with :success
        should_render_template :new
        should_render_a_form
      end
      context "and sends valid data" do
        setup do
          @user = Factory(:user)
          post :create, :user => Factory.attributes_for(:user, :login => "mr-henry")
        end
        
        should_redirect_to "root_url"
      end
    end
  end
  
  context "on PUT to :update" do
    context "when logged in" do
      context "and sends invalid data" do
        setup do
          @user = Factory(:user)
          set_session_for @user
          put :update, :id => @user.id, :user => { :login => "" }
        end
      
        should_respond_with :success
        should_render_template "users/edit.html.erb"
        should_render_a_form
      end
      context "and sends valid data" do
        setup do
          @user = Factory(:user)
          set_session_for @user
          put :update, :id => @user.id, :user => Factory.attributes_for(:user, :login => "mr-henry")
        end
        
        should_redirect_to "root_url"
      end
    end
    context "when not logged in" do
      setup do
        @user = Factory(:user)
        put :update, :id => @user.id, :user => Factory.attributes_for(:user, :login => "mr-henry")
      end
      
      should_redirect_to "home_url"
    end
  end
  
end