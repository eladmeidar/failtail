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
  
  def owner?(record, aggregate=false)
    case record
    when Membership
      if aggregate
        record.role == 'owner' and record.user_id == self.id
      else
        record.user_id == self.id
      end
    when Project    then owner?(memberships.first(:conditions => {:project_id => record.id}), true)
    when Error      then owner?(record.project, true)
    when Occurence  then owner?(record.error, true)
    else false
    end
  end
  
  def member?(record)
    case record
    when Membership then record.user_id == self.id
    when Project    then owner?(memberships.first(:conditions => { :project_id => record.id }))
    when Error      then owner?(record.project)
    when Occurence  then owner?(record.error)
    else false
    end
  end
  
end
