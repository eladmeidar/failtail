require 'test_helper'

class OccurenceTest < ActiveSupport::TestCase
  
  should_require_attributes :error
  should_require_attributes :name
  should_require_attributes :description
  should_require_attributes :properties
  should_require_attributes :reporter
  
  should_belong_to :error
  
  context "Occurence" do
    setup do
      @msg = 'properties must be a hash with strings for keys and values.'
    end
    context "with non-hash properties" do
      should "be invalid" do
        occurence = Factory.build(:occurence, :properties => "invalid data")
        assert ! occurence.valid?
        assert_equal @msg, occurence.errors.on(:properties)
      end
    end
    context "with non-string keys for properties" do
      should "be invalid" do
        occurence = Factory.build(:occurence, :properties => {
          5 => 'world',
          'bye' => 'moon'
        })
        assert ! occurence.valid?
        assert_equal @msg, occurence.errors.on(:properties)
      end
    end
    context "with non-string values for properties" do
      should "be invalid" do
        occurence = Factory.build(:occurence, :properties => {
          'hello' => 4,
          'bye' => 'moon'
        })
        assert ! occurence.valid?
        assert_equal @msg, occurence.errors.on(:properties)
      end
    end
    should "be valid when the properties is valid" do
      occurence = Factory.build(:occurence, :properties => {
        'hello' => 'world',
        'bye' => 'moon'
      })
      assert_valid occurence
    end
  end
  
end
