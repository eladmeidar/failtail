require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  
  context "on POST to :create" do
    
    formats = {'application/xml' => 'xml', 'application/json' => 'json'}
    formats.each do |format, extention|
      context "with format #{format.inspect}" do
        
        setup do
          project = Factory(:project)
          error = Factory.attributes_for(:error, :project => project).
            slice(:hash_string).
            stringify_keys
          occurence = Factory.attributes_for(:occurence, :error => error).
            slice(:name, :description, :backtrace, :properties).
            stringify_keys
          @report = {
            'project' => { 'api_token' => project.api_token },
            'error' => error,
            'occurence' => occurence
          }
        end
        
        context "with valid post data" do
          setup do
            post( :create,
                { :report => @report, :format => extention })
          end
          
          should_respond_with :created
          should_respond_with_content_type format
        end
        
        context "with missing project" do
          setup do
            @report.except!('project')
            post( :create,
                { :report => @report, :format => extention })
          end
          
          should_respond_with :unprocessable_entity
          should_respond_with_content_type format
        end
        
        context "with missing error" do
          setup do
            @report.except!('error')
            post( :create,
                { :report => @report, :format => extention })
          end
          
          should_respond_with :unprocessable_entity
          should_respond_with_content_type format
        end
        
        context "with missing occurence" do
          setup do
            @report.except!('occurence')
            post( :create,
                { :report => @report, :format => extention }) 
          end
          
          should_respond_with :unprocessable_entity
          should_respond_with_content_type format
        end
        
      end
      
    end
  end
  
end
