require 'test_helper'

class ErrorTest < ActiveSupport::TestCase
  
  should_validate_presence_of :project_id
  should_validate_presence_of :hash_string
  
  should_belong_to :project
  should_have_many :occurences, :dependent => :destroy
  
  should_have_index :project_id
  should_have_index :closed
  
  context "with other errors" do
    setup do
      Factory(:error)
    end
    
    should_validate_uniqueness_of :hash_string, :scoped_to => :project_id
  end
end
