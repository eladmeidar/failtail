class Error < ActiveRecord::Base
  
  validates_presence_of :project_id
  validates_presence_of :name
  validates_presence_of :hash_string
  validates_presence_of :description
  
  validates_uniqueness_of :hash_string, :scope => :project_id
  
  validate do |error|
    msg = "properties must be a hash with strings for keys and values."
    unless error.properties.nil?
      if error.properties.is_a? Hash
        error.properties.each do |k,v|
          unless k.is_a?(String) and v.is_a?(String)
            error.errors.add(:properties, msg)
            break
          end
        end
      else
        error.errors.add(:properties, msg)
      end
    end
  end
  
  serialize(:properties)
  def properties
    read_attribute(:properties) || {}
  end
  
  belongs_to :project
  has_many :occurences, :dependent => :destroy, :order => 'updated_at DESC'
  
  named_scope :with_hash, lambda { |h|
    { :conditions => { :hash_string => h } } }
  
end
