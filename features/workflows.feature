Feature: Workflows

  Background:
    Given I am Ben Franklin
    And Martha Washington exists
    And I go to the new user session page
    And I fill in "Email" with "ben@franklin.com"
    And I fill in "Password" with "Password1"
    And I press "Log in"

  Scenario: User can see all workflows
    Then I should see "okayworkflow"

  Scenario: User can create workflow
    When I click on "New Workflow"
    And I fill in "Name" with "Great Workflow"
    And I press "Save"
    Then I should see "Great Workflow"

  Scenario: System prevents a new workflow without a name
    When I click on "New Workflow"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see "Name can't be blank"

  Scenario: User can view workflow
    When I follow "okayworkflow"
    And I should see "okayworkflow"

  Scenario: User can edit and update a workflow
    When I follow "okayworkflow"
    And I click on "Edit"
    And I fill in "Name" with "slightlybettertoolbox"
    And I press "Save"
    Then I should see "slightlybettertoolbox"

  Scenario: System prevents invalid update
    When follow "okayworkflow"
    When I click on "Edit"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see "Name can't be blank"

  Scenario: User can delete a workflow
    When follow "okayworkflow"
    And I click on "Delete"
    Then I should see "Workflows"
    And I should not see "okayworkflow"
