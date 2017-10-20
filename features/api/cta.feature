Feature: Call-to-Action (CTA)

  Background:
    Given I am Callto Action
    And I send and accept JSON

  Scenario: Step returns CTA if present
    When I send a POST request to "/api/workflows/cta/steps" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "hello",
      "text": "Hello.",
      "cta": "Would you like to play a game?",
      "parts": [
        { "type": "text", "content": "Hello." }
      ]
    }
    """
