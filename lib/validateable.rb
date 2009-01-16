
module Validateable

  [:save, :save!, :update_attribute].each{|attr| define_method(attr){}}

  def method_missing(symbol, *params)
    if(symbol.to_s =~ /(.*)_before_type_cast$/)
      send($1)
    end
  end

  def self.append_features(base)
    super
    base.send :include, ActiveRecord::Validations
    base.extend ::Validateable::ClassMethods

    base.send :include, ActiveSupport::Callbacks
    base.define_callbacks *ActiveRecord::Validations::VALIDATIONS
  end

  module ClassMethods
    def self_and_descendents_from_active_record
      [self]
    end
    def human_attribute_name(attr)
      attr.humanize
    end
    def human_name
      self.to_s.humanize
    end
  end

end
