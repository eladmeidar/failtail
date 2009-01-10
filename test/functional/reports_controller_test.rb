require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  
  context "on POST to :create" do
    setup do
      project = Factory(:project)
      error = Factory.attributes_for(:error, :project => project).
        slice(:properties, :name, :description, :hash_string, :backtrace).
        stringify_keys
      occurence = Factory.attributes_for(:occurence, :error => error).
        slice(:properties).
        stringify_keys
      @report = {
        'project' => { 'api_token' => project.api_token },
        'error' => error,
        'occurence' => occurence
      }
    end
    
    context "with valid post data" do
      setup do
        post :create, { :report => @report },
                        'Content Type' => 'application/xml'
      end
      
      should_respond_with :created
      should_respond_with_content_type :xml
    end
    
    context "with missing project" do
      setup do
        @report.except!('project')
        post :create, { :report => @report },
                        'Content Type' => 'application/xml'
      end
      
      should_respond_with :unprocessable_entity
      should_respond_with_content_type :xml
    end
    
    context "with missing error" do
      setup do
        @report.except!('error')
        post :create, { :report => @report },
                        'Content Type' => 'application/xml'
      end
      
      should_respond_with :unprocessable_entity
      should_respond_with_content_type :xml
    end
    
    context "with missing occurence" do
      setup do
        @report.except!('occurence')
        post :create, { :report => @report },
                        'Content Type' => 'application/xml'
      end
      
      should_respond_with :unprocessable_entity
      should_respond_with_content_type :xml
    end
    
  end
  
end
