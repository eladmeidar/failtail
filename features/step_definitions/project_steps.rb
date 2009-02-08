# Given a project "My Project" owned by "john-doe"

Given /^a project "(.+)" owned by "(.+)"$/ do |project_name, owner_login|
  user = User.find_by_login(owner_login)
  user.projects.create!(:name => project_name)
end