Feature: New lines

  Background:
    Given the "New Line" workflow exists
    And I send and accept JSON

  Scenario: Split text divided by new line
    When I send a POST request to "/api/workflows/newline/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "newline",
      "text": "Texting a token\nto your phone.",
      "parts": [
        { "type": "text", "content": "Texting" },
        { "type": "text", "content": "a" },
        { "type": "text", "content": "token" },
        { "type": "newline" },
        { "type": "text", "content": "to" },
        { "type": "text", "content": "your" },
        { "type": "text", "content": "phone." }
      ]
    }
    """
    And the response status should be "201"
