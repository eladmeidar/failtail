class Error < ActiveRecord::Base
  
  validates_presence_of :project_id
  validates_presence_of :name
  validates_presence_of :hash_string
  validates_presence_of :description
  
  validates_uniqueness_of :hash_string, :scope => :project_id
  
  belongs_to :project
  has_many :occurences, :dependent => :destroy
  
end
