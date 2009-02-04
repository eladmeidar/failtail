class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of :name
  validates_presence_of :login
  validates_presence_of :email
  
  validates_length_of :name, :minimum => 2
  validates_length_of :login, :minimum => 2
  
  validates_uniqueness_of :login
  validates_uniqueness_of :email
  
  has_many :owned_projects, :dependent => :destroy,
    :class_name => "Project", :foreign_key => "owner_id"
  has_many :memberships, :dependent => :destroy
  has_many :projects, :through => :memberships
  
  def owner?(record)
    case record
    when Membership then record.role == 'owner'
    when Project    then owner?(memberships.first(:conditions => { :project_id => record.id }))
    when Error      then owner?(record.project)
    when Occurence  then owner?(record.error)
    else false
    end
  end
  
  def member?(record)
    case record
    when Membership then true
    when Project    then owner?(memberships.first(:conditions => { :project_id => record.id }))
    when Error      then owner?(record.project)
    when Occurence  then owner?(record.error)
    else false
    end
  end
  
end
