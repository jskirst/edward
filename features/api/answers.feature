Feature: answers

  Background:
    Given I am "Developer Alpha"
    And I send and accept JSON

  Scenario: System prevents access without api_key
    When I send a POST request to "/api/workflows/okayflow/answers?api_key=12345" with the following:
    """
    {
      "name": "newanswer",
      "input_type": "short_text",
      "mask": "###",
      "text_field_type": "text"
    }
    """
    Then the response status should be "401"
    And the JSON response should be:
    """
    {
      "error": "Request denied."
    }
    """

  Scenario: Create a answer
    When I send a POST request to "/api/workflows/okayflow/answers?api_key=ABCDE" with the following:
    """
    {
      "name": "newanswer",
      "input_type": "short_text",
      "mask": "###",
      "text_field_type": "text"
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "name": "newanswer",
      "input_type": "short_text",
      "mask": "###",
      "text_field_type": "text"
    }
    """

  Scenario: Get a answer
    When I send a GET request to "/api/workflows/okayflow/answers/okayanswer?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "name": "okayanswer",
      "input_type": "short_text",
      "mask": "###",
      "text_field_type": "text"
    }
    """

  Scenario: Get all answers
    When I send a GET request to "/api/workflows/okayflow/answers?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    [
      {
        "name": "okayanswer",
        "input_type": "short_text",
        "mask": "###",
        "text_field_type": "text"
      }
    ]
    """

  Scenario: Patch a answer
    When I send a PATCH request to "/api/workflows/okayflow/answers/okayanswer?api_key=ABCDE"
    """
    {
      "name": "updatedanswer",
      "input_type": "short_text",
      "mask": "###",
      "text_field_type": "number"
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "name": "updatedanswer",
      "input_type": "short_text",
      "mask": "###",
      "text_field_type": "number"
    }
    """

  Scenario: Delete a answer
    When I send a DELETE request to "/api/workflows/okayflow/answers/okayanswer?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "name": "okayanswer",
      "input_type": "short_text",
      "mask": "###",
      "text_field_type": "text"
    }
    """
