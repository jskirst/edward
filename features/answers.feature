Feature: Answers

  Background:
    Given I am Ben Franklin
    And Martha Washington exists
    And I go to the new user session page
    And I fill in "Email" with "ben@franklin.com"
    And I fill in "Password" with "Password1"
    And I press "Log in"

  Scenario: User can see all answers for a workflow
    When I follow "okayworkflow"
    Then I should see "goodanswer"

  Scenario: User can create a new answer
    When I follow "okayworkflow"
    When I click on "New Answer"
    And I fill in "Name" with "betteranswer"
    And I fill in "Input type" with "short_text"
    And I fill in "Text field type" with "text"
    And I fill in "Characters" with "12"
    And I press "Save"
    Then I should see "betteranswer"

  Scenario: System prevents a new answer without text
    When I follow "okayworkflow"
    When I click on "New Answer"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see "Name can't be blank"

  Scenario: User can edit and update a workflow
    When I follow "okayworkflow"
    And I follow "goodanswer"
    And I fill in "Name" with "newname"
    And I press "Save"
    Then I should see "newname"
    And I should not see "goodanswer"

  Scenario: System prevents invalid update
    When follow "okayworkflow"
    And I follow "goodanswer"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see "Name can't be blank"

  Scenario: User can delete a answer
    When follow "okayworkflow"
    And I follow "goodanswer"
    And I click on "Delete"
    Then I should see "okayworkflow"
    And I should not see "goodanswer"

  Scenario: User can copy a answer
    When follow "okayworkflow"
    And I follow "selectanswer"
    And I press "Copy"
    Then I should see "copy_selectanswer"
    And I should see "Huh?"
