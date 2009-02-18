class Project < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :api_token
  
  validates_uniqueness_of :api_token
  
  has_many :memberships, :dependent => :destroy
  has_many :members, :through => :memberships, :source => :user
  has_many :service_settings, :dependent => :destroy, :as => :service_owner
  
  # we can't user 'errors' here as it would conflict with AR's error handeling
  has_many :reports, :dependent => :destroy, :order => 'updated_at DESC',
    :class_name => "Error", :foreign_key => "project_id", :include => :last_occurence
  
  named_scope :with_api_token, lambda { |t|
    { :conditions => { :api_token => t } } }
  
  before_validation :generate_api_token
  
  before_create { |r| r.instance_variable_set('@fresh', true) }
  
  def fresh?
    @fresh == true
  end
  
  private
  
  def generate_api_token
    self.api_token ||= Digest::SHA1.hexdigest("--#{self.name}--#{DateTime.new}--")
  end
  
end
