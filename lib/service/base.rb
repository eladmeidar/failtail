module Service
  class Base
    
    class_inheritable_array :locations
    
    def self.appear_in(*locations)
      self.locations = locations
    end
    
    def self.report(occurence, settings)
      new(occurence, settings).report
    end
    
    attr_reader :settings, :occurence
    
    def initialize(occurence, settings)
      @settings, @occurence = settings, occurence
    end
    
    def report
      
    end
    
  end
end