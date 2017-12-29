Feature: Simulated authentication and introduction flow

  Background:
    Given the "Auth Example" workflow exists
    And I send and accept JSON

  Scenario:
    When I send a POST request to "/api/workflows/auth/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "phone",
      "text": "Texting token.\n{{?user_phone_number}}",
      "parts": [
        { "type": "text", "content": "Texting" },
        { "type": "text", "content": "token." },
        { "type": "newline" },
        { "type": "short_text", "name": "user_phone_number", "text_field_type": "number", "characters": 11, "mask": "(###) ###-####" }
      ]
    }
    """
    And the response status should be "201"

  Scenario:
    When I send a POST request to "/api/workflows/auth/prompts" with the following:
    """
    {
      "facts": {
        "user_phone_number": "6505294962"
      }
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "confirmation",
      "text": "Please enter code.\n{{?user_confirmation_token}}",
      "parts": [
        { "type": "text", "content": "Please" },
        { "type": "text", "content": "enter" },
        { "type": "text", "content": "code." },
        { "type": "newline" },
        { "type": "short_text", "name": "user_confirmation_token", "text_field_type": "number", "characters": 6, "mask": "####" }
      ]
    }
    """

  Scenario:
    When I send a POST request to "/api/workflows/auth/prompts" with the following:
    """
    {
      "facts": {
        "user_phone_number": "6505294962",
        "user_confirmation_token": "1234"
      }
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "thankyou",
      "text": "Thank you!{{?auth_token}}",
      "parts": [
        { "type": "text", "content": "Thank" },
        { "type": "text", "content": "you!" },
        { "type": "hidden", "name": "auth_token", "value": "1234" }
      ]
    }
    """
