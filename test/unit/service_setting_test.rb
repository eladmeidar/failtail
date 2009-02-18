require 'test_helper'

class ServiceSettingTest < ActiveSupport::TestCase
  
  setup do
    Factory(:service_setting)
  end
  
  should_have_db_column :service_owner_id,   :type => "integer"
  should_have_db_column :service_owner_type, :type => "string"
  should_have_db_column :service_type,       :type => "string"
  should_have_db_column :new_errors_only,    :type => "boolean", :default => false
  should_have_db_column :properties,         :type => "text"
  
  should_validate_presence_of :service_owner_id
  should_validate_presence_of :service_owner_type
  should_validate_presence_of :service_type
  should_validate_presence_of :properties
  
  should_have_index :service_owner_id
  should_have_index :service_owner_type
  
  should_validate_uniqueness_of :service_type,
    :scoped_to => [:service_owner_id, :service_owner_type]
  
  should_belong_to :service_owner
  
end
