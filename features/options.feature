Feature: Options

  Background:
    Given I am "Ben Franklin"
    And "Martha Washington" exists
    And I go to the new user session page
    And I fill in "Email" with "ben@franklin.com"
    And I fill in "Password" with "Password1"
    And I press "Log in"

  Scenario: User can see all options for a workflow
    When I follow "okayworkflow"
    Then I should see "Yes! / yes"

  Scenario: User can create a new option
    When I follow "okayworkflow"
    When I click on "New Option"
    And I fill in "Value" with "no"
    And I fill in "Text" with "No!"
    And I press "Save"
    Then I should see "No! / no"

  Scenario: System prevents a new option without text
    When I follow "okayworkflow"
    When I click on "New Option"
    And I fill in "Value" with ""
    And I press "Save"
    Then I should see "Value can't be blank"

  Scenario: User can edit and update a workflow
    When I follow "okayworkflow"
    And I follow "Yes! / yes"
    And I fill in "Text" with "Yeees!"
    And I press "Save"
    Then I should see "Yeees! / yes"
    And I should not see "Yes! / yes"

  Scenario: System prevents invalid update
    When follow "okayworkflow"
    And I follow "Yes! / yes"
    And I fill in "Text" with ""
    And I press "Save"
    Then I should see "Text can't be blank"

  Scenario: User can delete a option
    When follow "okayworkflow"
    And I follow "Yes! / yes"
    And I click on "Delete"
    Then I should see "okayworkflow"
    And I should not see "Yes! / yes"
