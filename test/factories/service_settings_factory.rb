
Factory.define :service_setting do |f|
  f.association :service_owner, :factory => :membership
  f.service_type 'mail'
  f.properties({ :hello => true })
end