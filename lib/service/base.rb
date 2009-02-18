module Service
  class Base
    
    def self.enabled_services
      @enabled_services ||= begin
        if FAILTALE[:services]
          FAILTALE[:services].collect(&:to_s)
        else
          ['mail']
        end
      end
    end
    
    def type_name
      self.to_s.sub(/Service$/, '').underscore
    end
    
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