require 'test_helper'

class ErrorTest < ActiveSupport::TestCase
  
  should_require_attributes :project_id
  should_require_attributes :hash_string
  should_require_attributes :name
  should_require_attributes :description
  
  
  should_belong_to :project
  should_have_many :occurences, :dependent => :destroy
  
  context "with other errors" do
    setup do
      Factory(:error)
    end
    
    should_require_unique_attributes :hash_string, :scoped_to => :project_id
  end
  
end
