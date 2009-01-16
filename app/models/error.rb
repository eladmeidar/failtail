class Error < ActiveRecord::Base
  
  validates_presence_of :project_id
  validates_presence_of :hash_string
  
  validates_uniqueness_of :hash_string, :scope => :project_id
  
  belongs_to :project
  has_many :occurences, :dependent => :destroy, :order => 'updated_at DESC'
  
  named_scope :with_hash, lambda { |h|
    { :conditions => { :hash_string => h } } }
  
  delegate :name, :description, :to => :last_occurence
  delegate :properties, :properties?, :to => :last_occurence
  delegate :backtrace, :backtrace?, :to => :last_occurence
  
  private
  
  # the last ocurence is first
  def last_occurence
    self.occurences.first
  end
  
end
