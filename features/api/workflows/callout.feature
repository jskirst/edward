Feature: Callouts

  Background:
    Given the "Call Out" workflow exists
    And I send and accept JSON

  # Note: Only comparison with integers and floats works
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

  Scenario: Steps with successful callout response testing integer value
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
      "text": "You got it!Secret: {{$..secret[:0].value}}",
      "parts": [
        { "type": "text", "content": "You" },
        { "type": "text", "content": "got" },
        { "type": "text", "content": "it!" },
        { "type": "text", "content": "Secret:" },
        { "type": "text", "content": "123" }
      ]
    }
    """

  Scenario: Steps with failed callout response testing integer value
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

  Scenario: Steps with successful callout response testing presence of boolean
    When I send a POST request to "/api/workflows/callout/prompts" with the following:
    """
    {
    "facts": { "present": "true"}
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "present",
      "text": "Present! {{$..present}}",
      "parts": [
        { "type": "text", "content": "Present!" },
        { "type": "text", "content": "And" },
        { "type": "text", "content": "accounted" },
        { "type": "text", "content": "for!" }
      ]
    }
    """

  Scenario: Steps with unsuccessful callout response testing presence of boolean
    When I send a POST request to "/api/workflows/callout/prompts" with the following:
    """
    {
    "facts": { "present": "false"}
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "present",
      "text": "Not present",
      "cta": "Oh well",
      "parts": [
        { "type": "text", "content": "Not" },
        { "type": "text", "content": "present" }
      ]
    }
    """
