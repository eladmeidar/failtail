class Membership < ActiveRecord::Base
  
  validates_presence_of :user_id
  validates_presence_of :project_id
  
  validates_uniqueness_of :user_id, :scope => :project_id
  
  belongs_to :user
  belongs_to :project
  
end
