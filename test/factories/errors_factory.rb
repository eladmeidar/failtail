
Factory.sequence :hash_string do |n|
  "hash#{n}"
end

Factory.define :error do |f|
  f.association :project, :factory => :project
  f.hash_string { Factory.next(:hash_string) }
end
