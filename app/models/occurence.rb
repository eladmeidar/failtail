class Occurence < ActiveRecord::Base
  
  validates_presence_of :error_id
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :properties
  
  validate do |error|
    msg = "properties must be a hash with strings for keys and values."
    if error.properties
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
  
  belongs_to :error, :counter_cache => true
  
end
