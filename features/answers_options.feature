Feature: Answers Options

  Background:
    Given I am Ben Franklin
    And Martha Washington exists
    And I go to the new user session page
    And I fill in "Email" with "ben@franklin.com"
    And I fill in "Password" with "Password1"
    And I press "Log in"

  Scenario: User can see all options for an answer
    When I follow "okayworkflow"
    And I follow "selectanswer"
    And I should see "Yes! / yes"
    And I should not see "Huh? / huh"

  Scenario: User can add option to answer
    When I follow "okayworkflow"
    And I follow "selectanswer"
    And I follow "Add Option"
    And I select "Huh?" from "Option"
    And I press "Save"
    And I should see "Huh? / huh"

  Scenario: User can remove an option from an answer
    When I follow "okayworkflow"
    And I follow "selectanswer"
    And I click on "Remove"
    Then I should not see "Yes! / yes"
    And I should see "At least 1 option is required"
