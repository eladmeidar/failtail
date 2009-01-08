class Project < ActiveRecord::Base
  
  validates_presence_of :owner_id
  validates_presence_of :name
  validates_presence_of :api_token
  
  validates_uniqueness_of :api_token
  validates_uniqueness_of :name, :scope => :owner_id
  
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many :memberships, :dependent => :destroy
  has_many :members, :through => :memberships, :source => :user
  
  # we can't user 'errors' here as it would conflict with AR's error handeling
  has_many :reports, :dependent => :destroy,
    :class_name => "Error", :foreign_key => "project_id"
  
end
