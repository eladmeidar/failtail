
Factory.define :membership do |f|
  f.association :user, :factory => :user
  f.association :project, :factory => :project
end
