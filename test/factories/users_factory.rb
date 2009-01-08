
Factory.sequence :user_name do |n|
  "User #{n}"
end

Factory.sequence :login do |n|
  "user#{n}"
end

Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |f|
  f.name  { Factory.next(:user_name) }
  f.login { Factory.next(:login) }
  f.email { Factory.next(:email) }
  f.password 'aaabbb'
  f.password_confirmation 'aaabbb'
end
