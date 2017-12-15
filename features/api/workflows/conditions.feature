Feature: Conditions

  Background:
    Given I send and accept JSON
    Given the "Conditions" workflow exists

  Scenario: Step can be matched with a > sign
    When I send a POST request to "/api/workflows/conditions/prompts" with the following:
    """
    {
    "facts": { "count": "4" }
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "greaterthen",
      "text": "Count is > 3",
      "parts": [
        { "type": "text", "content": "Count" },
        { "type": "text", "content": "is" },
        { "type": "text", "content": ">" },
        { "type": "text", "content": "3" }
      ]
    }
    """
    And the response status should be "201"

  Scenario: Step can be matched with a > sign
    When I send a POST request to "/api/workflows/conditions/prompts" with the following:
    """
    {
    "facts": { "count": 2 }
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "lessthen",
      "text": "Count is < 3",
      "parts": [
        { "type": "text", "content": "Count" },
        { "type": "text", "content": "is" },
        { "type": "text", "content": "<" },
        { "type": "text", "content": "3" }
      ]
    }
    """
    And the response status should be "201"

