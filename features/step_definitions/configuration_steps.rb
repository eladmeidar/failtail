
Given /^user registration is (not allowed|allowed)$/ do |allowed|
  FAILTALE[:allow_registration] = (allowed == 'allowed')
end

Given /^invitations are (not allowed|allowed)$/ do |allowed|
  FAILTALE[:allow_invitations] = (allowed == 'allowed')
end
