require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  
  context "on GET to :home" do
    setup { get :home }

    should_respond_with :success
  end
  
end
