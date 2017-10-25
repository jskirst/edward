Feature: Steps

  Background:
    Given I am Andy Developer
    And I send and accept JSON

  Scenario: System prevents access without api_key
    When I send a POST request to "/api/workflows/okayflow/steps?api_key=12345" with the following:
    """
    {
      "token": "newstep",
      "text": "okay text",
      "conditions": "real="
    }
    """
    Then the response status should be "401"
    And the JSON response should be:
    """
    {
      "error": "Request denied."
    }
    """

  Scenario: Create a step
    When I send a POST request to "/api/workflows/okayflow/steps?api_key=ABCDE" with the following:
    """
    {
      "token": "newstep",
      "text": "new text",
      "conditions": "new="
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "newstep",
      "text": "new text",
      "conditions": "new="
    }
    """

  Scenario: Get a step
    When I send a GET request to "/api/workflows/okayflow/steps/okaystep?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "okaystep",
      "text": "okay text",
      "conditions": "hmm="
    }
    """

  Scenario: Get all steps
    When I send a GET request to "/api/workflows/okayflow/steps?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    [
      {
        "token": "okaystep",
        "text": "okay text",
        "conditions": "hmm="
      }
    ]
    """

  Scenario: Patch a step
    When I send a PATCH request to "/api/workflows/okayflow/steps/okaystep?api_key=ABCDE"
    """
    {
      "token": "updatedstep",
      "text": "new text",
      "conditions": "ahh="
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "updatedstep",
      "text": "new text",
      "conditions": "ahh="
    }
    """

  Scenario: Delete a step
    When I send a DELETE request to "/api/workflows/okayflow/steps/okaystep?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "okaystep",
      "text": "okay text",
      "conditions": "hmm="
    }
    """
