class Membership < ActiveRecord::Base
  
  validates_presence_of :user_id
  validates_presence_of :project_id
  validates_presence_of :role
  
  validates_uniqueness_of :user_id, :scope => :project_id
  
  belongs_to :user
  belongs_to :project
  
  attr_accessor :email
  before_validation :lookup_user_by_email
  
  def project_id=(id)
    if id and Membership.count(:conditions => ["(role = ?) AND (project_id = ?)", 'owner', id]) == 0
      self[:role]='owner'
    end
    self[:project_id] = id
  end
  
  private
  
  def lookup_user_by_email
    unless self.email.blank?
      self.user = User.find_by_email(self.email)
    end
  end
  
end
