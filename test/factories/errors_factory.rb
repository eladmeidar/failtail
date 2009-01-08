
Factory.sequence :hash_string do |n|
  "hash#{n}"
end

Factory.sequence :error_name do |n|
  "Error #{n}"
end

Factory.define :error do |f|
  f.association :project, :factory => :project
  f.hash_string { Factory.next(:hash_string) }
  f.name { Factory.next(:error_name) }
  f.description 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
end
