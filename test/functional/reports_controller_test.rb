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
            stringify_keys.with_indifferent_access
          occurence = Factory.attributes_for(:occurence, :error => error).
            slice(:name, :description, :backtrace, :properties, :reporter).
            stringify_keys.with_indifferent_access
          @report = {
            'project' => { 'api_token' => project.api_token }.with_indifferent_access,
            'error' => error,
            'occurence' => occurence
          }.with_indifferent_access
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
        
        context "with invalid occurence" do
          setup do
            @report[:occurence] = @report[:occurence].except!('name')
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
