require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  
  context "with Project" do
    setup do
      @project = Factory(:project)
    end
    
    context "and params" do
      
      setup do
        error = Factory.attributes_for(:error, :project => @project).
          slice(:hash_string).
          stringify_keys.with_indifferent_access
        occurence = Factory.attributes_for(:occurence, :error => error).
          slice(:name, :description, :backtrace, :properties, :reporter).
          stringify_keys.with_indifferent_access
        @valid = {
          'project' => { 'api_token' => @project.api_token }.with_indifferent_access,
          'error' => error,
          'occurence' => occurence
        }.with_indifferent_access
      end
      
      should "require any param" do
        assert_raise ActiveRecord::RecordInvalid do
          Report.create!({ })
        end
      end
      should "require :project param" do
        assert_raise ActiveRecord::RecordInvalid do
          Report.create!(@valid.except('project'))
        end
      end
      should "require :error param" do
        assert_raise ActiveRecord::RecordInvalid do
          Report.create!(@valid.except('error'))
        end
      end
      should "require :occurence param" do
        assert_raise ActiveRecord::RecordInvalid do
          Report.create!(@valid.except('occurence'))
        end
      end
      should "save when valid" do
        assert_nothing_raised do
          Report.create!(@valid)
        end
      end
      
    end
  end
  
end
