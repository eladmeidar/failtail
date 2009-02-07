class Error < ActiveRecord::Base
  
  validates_presence_of :project_id
  validates_presence_of :hash_string
  
  validates_uniqueness_of :hash_string, :scope => :project_id
  
  belongs_to :project, :counter_cache => true
  has_many :occurences, :dependent => :destroy, :order => 'updated_at DESC'
  has_one :last_occurence, :class_name => "Occurence", :order => 'id ASC'
  
  named_scope :with_hash, lambda { |h|
    { :conditions => { :hash_string => h } } }
  
  delegate :name, :description, :to => :last_occurence
  delegate :properties, :properties?, :to => :last_occurence
  delegate :backtrace, :backtrace?, :to => :last_occurence
  
end
