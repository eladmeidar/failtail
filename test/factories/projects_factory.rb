
Factory.sequence :project_name do |n|
  "Project #{n}"
end

Factory.sequence :api_token do |n|
  "hash#{n}"
end

Factory.define :project do |f|
  f.association :owner, :factory => :user
  f.name { Factory.next(:project_name) }
  f.api_token { Factory.next(:api_token) }
end
