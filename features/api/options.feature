Feature: Options

  Background:
    Given I am Developer Alpha
    And I send and accept JSON

  Scenario: System prevents access without api_key
    When I send a POST request to "/api/workflows/okayflow/options?api_key=12345" with the following:
    """
    {
      "text": "Hey!",
      "value": "hey"
    }
    """
    Then the response status should be "401"
    And the JSON response should be:
    """
    {
      "error": "Request denied."
    }
    """

  Scenario: Create a option
    When I send a POST request to "/api/workflows/okayflow/options?api_key=ABCDE" with the following:
    """
    {
      "token": "12345",
      "text": "Hey!",
      "value": "hey"
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "12345",
      "text": "Hey!",
      "value": "hey"
    }
    """

  Scenario: Get a option
    When I send a GET request to "/api/workflows/okayflow/options/okayoption?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "okayoption",
      "text": "Yes",
      "value": "yes"
    }
    """

  Scenario: Get all options
    When I send a GET request to "/api/workflows/okayflow/options?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    [
      {
        "token": "okayoption",
        "text": "Yes",
        "value": "yes"
      }
    ]
    """

  Scenario: Patch a option
    When I send a PATCH request to "/api/workflows/okayflow/options/okayoption?api_key=ABCDE"
    """
    {
      "token": "okayoption",
      "text": "Yes!",
      "value": "yes!"
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "okayoption",
      "text": "Yes!",
      "value": "yes!"
    }
    """

  Scenario: Delete a option
    When I send a DELETE request to "/api/workflows/okayflow/options/okayoption?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "okayoption",
      "text": "Yes",
      "value": "yes"
    }
    """
