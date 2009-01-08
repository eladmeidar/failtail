require 'test_helper'

class ErrorTest < ActiveSupport::TestCase
  
  should_require_attributes :project_id
  should_require_attributes :hash_string
  should_require_attributes :name
  should_require_attributes :description
  
  should_require_unique_attributes :hash_string, :scoped_to => :project_id
  
  should_belong_to :project
  should_have_many :occurences, :dependent => :destroy
  
end
