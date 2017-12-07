Feature: Links

  Background:
    Given the "Choices" workflow exists
    And I send and accept JSON

  Scenario: Text can have two choices, each with one fact change.
    When I send a POST request to "/api/workflows/choices/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "choices",
      "text": "Choices! {{!'This is choice one.'[facts=one%3Dtrue]}}\n {{!'This is choice two.'[facts=two%3Dtrue]}}",
      "parts": [
        { "type": "text", "content": "Choices!" },
        { "type": "choice", "content": "This is choice one.", "facts": "one%3Dtrue" },
        { "type": "newline" },
        { "type": "choice", "content": "This is choice two.", "facts": "two%3Dtrue" }
      ]
    }
    """
    And the response status should be "201"

  Scenario: Text can have one choice, but with 2 fact changes.
    When I send a POST request to "/api/workflows/choices/prompts" with the following:
    """
    {
    "facts": { "one": "true" }
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "one",
      "text": "You selected choice 1. {{!'Go to choice 2?'[facts=one%3Dtrue&two%3Dtrue]}}",
      "parts": [
        { "type": "text", "content": "You" },
        { "type": "text", "content": "selected" },
        { "type": "text", "content": "choice" },
        { "type": "text", "content": "1." },
        { "type": "choice", "content": "Go to choice 2?", "facts": "one%3Dtrue&two%3Dtrue" }
      ]
    }
    """
    And the response status should be "201"
