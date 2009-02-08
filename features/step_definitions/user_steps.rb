
Given /^a registered user with login "(.+)" and password "(.+)"$/ do |login, password|
  @user = Factory(:user, :login => login, :password => password, :password_confirmation => password)
end