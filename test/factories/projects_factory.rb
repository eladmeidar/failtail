
Factory.sequence :project_name do |n|
  "Project #{n}"
end

Factory.define :project do |f|
  f.name { Factory.next(:project_name) }
end
