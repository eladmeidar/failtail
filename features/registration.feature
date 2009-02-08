Feature: User Registration
In order to have an account
Guests should be able to
Create an account

Scenario: Register with valid data
  Given user registration is allowed
  When I go to the registration page
   And I fill in "Name" with "John Doe"
   And I fill in "Email" with "john-doe@failtale.be"
   And I fill in "Login" with "john-doe"
   And I fill in "Password" with "my password"
   And I fill in "Password confirmation" with "my password"
   And I press "Register"
  Then I should see "New project"

Scenario: Register with invalid data
  Given user registration is allowed
  When I go to the registration page
   And I fill in "Name" with "John Doe"
   And I fill in "Email" with ""
   And I fill in "Login" with "john-doe"
   And I fill in "Password" with "my password"
   And I fill in "Password confirmation" with "my password"
   And I press "Register"
  Then I should see "Email can't be blank"

Scenario: Registration is disabled
  Given user registration is not allowed
  When I go to the registration page
  Then I should see "We're in private beta but..."