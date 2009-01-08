class Occurence < ActiveRecord::Base
  
  validates_presence_of :error_id
  validates_presence_of :properties
  
  belongs_to :error
  
end
