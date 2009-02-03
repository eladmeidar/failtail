require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  
  context "with Project" do
    setup do
      @project = Factory(:project)
    end
    
    should "require error" do
      error = Factory.attributes_for(:error, :project => @project).
        slice(:hash_string).
        stringify_keys
      occurence = Factory.attributes_for(:occurence, :error => error).
        slice(:name, :description, :backtrace, :properties).
        stringify_keys
      valid = {
        'project' => { 'api_token' => @project.api_token },
        'error' => error,
        'occurence' => occurence
      }
      assert_raise Report::ReportInvalid do
        Report.create!({ })
      end
      assert_raise Report::ReportInvalid do
        Report.create!(valid.except('project'))
      end
      assert_raise Report::ReportInvalid do
        Report.create!(valid.except('error'))
      end
      assert_raise Report::ReportInvalid do
        Report.create!(valid.except('occurence'))
      end
      assert_nothing_raised do
        Report.create!(valid)
      end
    end
    
  end
  
end
