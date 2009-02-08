Feature: User Sign on
In order to view error reports
Guests should be able to
Login to there accounts

Scenario: Login with valid credentials
  Given a user with login "john-doe" and password "my password"
  When I go to the login page
   And I fill in "Login" with "john-doe"
   And I fill in "Password" with "my password"
   And I press "Login"
  Then I should see "New project"

Scenario: Login with valid credentials
  Given a user with login "john-doe" and password "my password"
  When I go to the login page
   And I fill in "Login" with "john-doe"
   And I fill in "Password" with ""
   And I press "Login"
  Then I should see "Password can not be blank"
