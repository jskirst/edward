Feature: Error handling

  Scenario: Workflow not found
    When I send a POST request to "/api/workflows/notreal/steps" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "404"
    And the JSON response should be:
    """
    {
      "error": "Workflow not found"
    }
    """

  Scenario: Matching step not found
    Given I am Cannot Match
    When I send a POST request to "/api/workflows/cannotmatch/steps" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "422"
    And the JSON response should be:
    """
    {
      "error": "No matching step found.",
      "facts": {}
    }
    """
