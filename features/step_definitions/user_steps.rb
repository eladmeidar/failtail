
Given /^a user with login "(.+)"(?: and password "(.+)")$/ do |login, password|
  password ||= "password"
  @user = Factory(:user, :login => login, :password => password, :password_confirmation => password)
end

Given /^a user is logged in as "(.*)"$/ do |login|
  @current_user = User.create!(
    :name => login,
    :login => login,
    :password => 'generic',
    :password_confirmation => 'generic',
    :email => "#{login}@example.com" 
  )

  visit "/user_session/new" 
  fill_in("Login", :with => login) 
  fill_in("Password", :with => 'generic') 
  click_button("Login")
  assert_match(/New project/m, response.body)
end