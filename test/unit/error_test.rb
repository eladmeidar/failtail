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
  
  context "Error" do
    setup do
      @msg = 'properties must be a hash with strings for keys and values.'
    end
    context "with non-hash properties" do
      should "be invalid" do
        error = Factory.build(:error, :properties => "some invalid data")
        assert ! error.valid?
        assert_equal @msg, error.errors.on(:properties)
      end
    end
    context "with non-string keys for properties" do
      should "be invalid" do
        error = Factory.build(:error, :properties => {
          5 => 'world',
          'bye' => 'moon'
        })
        assert ! error.valid?
        assert_equal @msg, error.errors.on(:properties)
      end
    end
    context "with non-string values for properties" do
      should "be invalid" do
        error = Factory.build(:error, :properties => {
          'hello' => 4,
          'bye' => 'moon'
        })
        assert ! error.valid?
        assert_equal @msg, error.errors.on(:properties)
      end
    end
    should "be valid when the properties is valid" do
      error = Factory.build(:error, :properties => {
        'hello' => 'world',
        'bye' => 'moon'
      })
      assert_valid error
    end
  end
  
end
