class Error < ActiveRecord::Base
  
  def self.per_page ; 20 ; end
  
  validates_presence_of :project_id
  validates_presence_of :hash_string
  
  validates_uniqueness_of :hash_string, :scope => :project_id
  
  belongs_to :project, :counter_cache => true
  has_many :occurences, :dependent => :destroy, :order => 'updated_at DESC'
  has_one :last_occurence, :class_name => "Occurence", :order => 'id DESC'
  
  named_scope :with_hash, lambda { |h|
    { :conditions => { :hash_string => h } } }
  named_scope :open,   :conditions => [ "errors.closed = ?", false ]
  named_scope :closed, :conditions => [ "errors.closed = ?", true  ]
  named_scope :owned_by, lambda { |user|
    { :conditions => { :project_id => user.project_ids } } }
  
  delegate :name, :description, :to => :last_occurence
  delegate :properties, :properties?, :to => :last_occurence
  delegate :backtrace, :backtrace?, :to => :last_occurence
  
end
