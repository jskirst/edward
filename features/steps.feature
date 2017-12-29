Feature: Steps

  Background:
    Given I am "Ben Franklin"
    And "Martha Washington" exists
    And I go to the new user session page
    And I fill in "Email" with "ben@franklin.com"
    And I fill in "Password" with "Password1"
    And I press "Log in"

  Scenario: User can see all steps for a workflow
    When I follow "okayworkflow"
    Then I should see "Are you okay?"

  Scenario: User can create a new step
    When I follow "okayworkflow"
    When I click on "New Step"
    And I fill in "Text" with "I'm great."
    And I fill in "Conditions" with "maybe="
    And I press "Save"
    Then I should see "I'm great."

  Scenario: System prevents a new step without text
    When I follow "okayworkflow"
    When I click on "New Step"
    And I fill in "Text" with ""
    And I press "Save"
    Then I should see "Text can't be blank"

  Scenario: User can edit and update a workflow
    When I follow "okayworkflow"
    And I follow "Are you okay?"
    And I fill in "Text" with "Slightly better text"
    And I press "Save"
    Then I should see "Slightly better text"

  Scenario: System prevents invalid update
    When follow "okayworkflow"
    And I follow "Are you okay?"
    And I fill in "Text" with ""
    And I press "Save"
    Then I should see "Text can't be blank"

  Scenario: User can delete a step
    When follow "okayworkflow"
    And I follow "Are you okay?"
    And I click on "Delete"
    Then I should see "okayworkflow"
    And I should not see "Are you okay?"

  Scenario: User can copy a step
    When follow "okayworkflow"
    And I follow "Are you okay?"
    And I press "Copy"
    Then I should see "Copy - Are you okay?"
