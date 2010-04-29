class ServiceSetting < ActiveRecord::Base

  belongs_to :service_owner, :polymorphic => true

  serialize :properties

  validates_presence_of :service_owner_type
  validates_presence_of :service_owner_id
  validates_presence_of :service_type
  validates_presence_of :properties
  validates_uniqueness_of :service_type, :scope => [:service_owner_id, :service_owner_type]

end
