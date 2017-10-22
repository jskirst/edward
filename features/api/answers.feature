Feature: Answers

  Scenario: Answer with numbers in name
    Given I am Alpha Numeric
    When I send a POST request to "/api/workflows/alphanumeric/steps" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "alphanumeric",
      "text": "Letter.{{?alpha_1}}",
      "parts": [
        { "type": "text", "content": "Letter." },
        { "type": "hidden", "name": "alpha_1" }
      ]
    }
    """

  Scenario: Answers with default_value set should return them
    Given I am Default Value
    When I send a POST request to "/api/workflows/defaultvalue/steps" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "defaultvalue",
      "text": "Default.{{?default_value}}",
      "parts": [
        { "type": "text", "content": "Default." },
        { "type": "hidden", "name": "default_value", "value": "true" }
      ]
    }
    """

