Feature: Text decoration

  Background:
    Given the "Text Decoration" workflow exists
    And I send and accept JSON

  Scenario: Pass attributes along with value
    When I send a POST request to "/api/workflows/textdecoration/prompts" with the following:
    """
    {
    "facts": { "bold": "true" }
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "bold",
      "text": "I am **bold.",
      "parts": [
        { "type": "text", "content": "I" },
        { "type": "text", "content": "am" },
        { "type": "text", "content": "bold.", "bold": "true" }
      ]
    }
    """
    And the response status should be "201"

