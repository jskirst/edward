Feature: Call-to-Action (CTA)

  Background:
    Given the "Cta" workflow exists
    And I send and accept JSON

  Scenario: Step returns CTA if present
    When I send a POST request to "/api/workflows/cta/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "hello",
      "text": "Hello.",
      "cta": "Would you like to play a game?",
      "cta_class": "this that",
      "cta_href": "https://www.example.com",
      "parts": [
        { "type": "text", "content": "Hello." }
      ]
    }
    """
    And the response status should be "201"
