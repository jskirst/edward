Feature: Callouts

  Background:
    Given I am Call Out
    And I send and accept JSON

  Scenario: Steps without callouts
    When I send a POST request to "/api/workflows/callout/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "guess",
      "text": "Pick a number.\n{{?number}}",
      "cta": "Guess",
      "parts": [
        { "type": "text", "content": "Pick" },
        { "type": "text", "content": "a" },
        { "type": "text", "content": "number." },
        { "type": "newline" },
        { "type": "short_text", "name": "number", "text_field_type": "text", "characters": 3, "mask": "#" }
      ]
    }
    """
    And the response status should be "201"

  Scenario: Steps with successful callout response
    When I send a POST request to "/api/workflows/callout/prompts" with the following:
    """
    {
      "facts": {
        "number": "1"
      }
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "result",
      "text": "You got it!{{@secret}}",
      "parts": [
        { "type": "text", "content": "You" },
        { "type": "text", "content": "got" },
        { "type": "text", "content": "it!" },
        { "type": "text", "content": "Secret: 123" }
      ]
    }
    """

  Scenario: Steps with failed callout response
    When I send a POST request to "/api/workflows/callout/prompts" with the following:
    """
    {
      "facts": {
        "number": "2"
      }
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "result",
      "text": "Wrong!{{@error}}\n{{?number}}",
      "cta": "Guess Again",
      "parts": [
        { "type": "text", "content": "Wrong!" },
        { "type": "text", "content": "It was something else." },
        { "type": "newline" },
        { "type": "short_text", "text_field_type": "text", "mask": "#", "name": "number", "characters": 3, "value": "2" }
      ]
    }
    """
