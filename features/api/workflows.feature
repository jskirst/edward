Feature: Workflows

  Background:
    Given I am "Developer Alpha"
    And I send and accept JSON

  Scenario: System prevents access without api_key
    When I send a POST request to "/api/workflows?api_key=12345" with the following:
    """
    {
      "token": "newworkflow"
    }
    """
    Then the response status should be "401"
    And the JSON response should be:
    """
    {
      "error": "Request denied."
    }
    """

  Scenario: Create a workflow
    When I send a POST request to "/api/workflows?api_key=ABCDE" with the following:
    """
    {
      "token": "newworkflow"
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "newworkflow"
    }
    """

  Scenario: Get a workflow
    When I send a GET request to "/api/workflows/okayflow?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "okayflow"
    }
    """

  Scenario: Get all workflows
    When I send a GET request to "/api/workflows?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    [
      {
        "token": "okayflow"
      }
    ]
    """

  Scenario: Patch a workflow
    When I send a PATCH request to "/api/workflows/okayflow?api_key=ABCDE"
    """
    {
      "token": "updatedflow"
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "updatedflow"
    }
    """

  Scenario: Delete a workflow
    When I send a DELETE request to "/api/workflows/okayflow?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "okayflow"
    }
    """
