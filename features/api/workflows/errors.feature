Feature: Error handling

  Background:
    Given I send and accept JSON

  Scenario: Workflow not found
    When I send a POST request to "/api/workflows/notreal/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "404"
    And the JSON response should be:
    """
    {
      "error": "Workflow not found."
    }
    """

  Scenario: Matching step not found
    Given the "Cannot Match" workflow exists
    When I send a POST request to "/api/workflows/cannotmatch/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "422"
    And the JSON response should be:
    """
    {
      "error": "No matching step found."
    }
    """

  Scenario: Answer not found
    Given the "Nosuch Answer" workflow exists
    When I send a POST request to "/api/workflows/nosuchanswer/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "500"
    And the JSON response should be:
    """
    {
      "error": "No Answer found for name: doesnotexist"
    }
    """
