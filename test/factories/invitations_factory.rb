
Factory.sequence :invitation_code do |n|
  "Invitation code #{n}"
end

Factory.define :invitation do |f|
  f.email { Factory.next(:email) }
  f.code  { Factory.next(:invitation_code) }
end