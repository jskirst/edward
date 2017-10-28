Feature: New lines

  Background:
    Given I am New Line
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
        { "type": "text", "content": "Texting a token" },
        { "type": "newline" },
        { "type": "text", "content": "to your phone." }
      ]
    }
    """
    And the response status should be "201"
