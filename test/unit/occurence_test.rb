require 'test_helper'

class OccurenceTest < ActiveSupport::TestCase
  
  should_require_attributes :error_id
  should_require_attributes :properties
  
  should_belong_to :error
  
end
