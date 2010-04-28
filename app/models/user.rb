class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of :name
  validates_presence_of :login
  validates_presence_of :email
  
  validates_length_of :name, :minimum => 2
  validates_length_of :login, :minimum => 2
  
  validates_uniqueness_of :login
  validates_uniqueness_of :email
  
  has_many :memberships, :dependent => :destroy
  has_many :projects, :through => :memberships
  has_many :owned_projects, :through => :memberships, :conditions => { 'memberships.role' => 'owner' }
  
  default_scope :order => 'name ASC'
  
  def owner?(record, aggregate=false)
    case record
    when Membership
      if aggregate
        record.role == 'owner' and record.user_id == self.id
      else
        record.user_id == self.id
      end
    when Project    then owner?(memberships.first(:conditions => {:project_id => record.id}), true)
    when ::Error    then owner?(record.project, true)
    when Occurence  then owner?(record.error, true)
    else false
    end
  end
  
  def member?(record)
    case record
    when Membership then record.user_id == self.id
    when Project    then member?(memberships.first(:conditions => { :project_id => record.id }))
    when ::Error    then member?(record.project)
    when Occurence  then member?(record.error)
    else false
    end
  end
  
  def gravatar_url(options={})
    return nil unless self.email
    @gravatar_url ||= Gravatar.url_for(self.email, options)
  end
  
  def can_create_one_more_project?
    self.admin or self.owned_projects.size < 3
  end
  
end
