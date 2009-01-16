
Factory.sequence :error_name do |n|
  "Error #{n}"
end

Factory.define :occurence do |f|
  f.association :error, :factory => :error
  f.name { Factory.next(:error_name) }
  f.properties( 'hello' => 'world' )
  f.description 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
end
