Feature: Users can manage projects

  As a user
  I want to manage projects
  So that I can group my error reports

  Scenario: Create a project with a valid name
    Given a user is logged in as "john-doe"
    When I go to the new project page
     And I fill in "Name" with "My Project"
     And I press "Create"
    Then I should see "My Project"

  Scenario: Create a project with an invalid name
    Given a user is logged in as "john-doe"
    When I go to the new project page
     And I fill in "Name" with ""
     And I press "Create"
    Then I should see "Name can't be blank"
  
  Scenario: Edit a Project with a valid name
    Given a user is logged in as "john-doe"
    Given a project "My Project" owned by "john-doe"
    When I go to the homepage
     And I follow "My Project"
     And I follow "Edit project"
     And I fill in "Name" with "My Other Project"
     And I press "Save"
    Then I should see "My Other Project"
  
  Scenario: Edit a Project with an invalid name
    Given a user is logged in as "john-doe"
    Given a project "My Project" owned by "john-doe"
    When I go to the homepage
     And I follow "My Project"
     And I follow "Edit project"
     And I fill in "Name" with ""
     And I press "Save"
    Then I should see "Name can't be blank"
  
  Scenario: Destroy a Project
    Given a user is logged in as "john-doe"
    Given a project "My Project" owned by "john-doe"
    When I go to the homepage
     And I follow "My Project"
     And I follow "Edit project"
     And I follow "Delete this project"
    Then I should not see "My Project"
