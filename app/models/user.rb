class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of :name
  validates_presence_of :login
  validates_presence_of :email
  
  validates_uniqueness_of :login
  validates_uniqueness_of :email
  
  has_many :owned_projects, :dependent => :destroy,
    :class_name => "Project", :foreign_key => "owner_id"
  has_many :memberships, :dependent => :destroy
  has_many :projects, :through => :memberships
  
end
