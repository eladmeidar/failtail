class Membership < ActiveRecord::Base
  
  validates_presence_of :user_id
  validates_presence_of :project_id
  
  validates_uniqueness_of :user_id, :scope => :project_id
  
  belongs_to :user
  belongs_to :project
  
  attr_accessor :email
  before_validation :lookup_user_by_email
  
  private
  
  def lookup_user_by_email
    unless self.email.blank?
      self.user = User.find_by_email(self.email)
    end
  end
  
end
