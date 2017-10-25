Feature: Simulated authentication and introduction flow

  Background:
    Given I am Arthur Dent
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
      "text": "Texting a token to your phone.\n{{?user_phone_number}}",
      "parts": [
        { "type": "text", "content": "Texting a token to your phone." },
        { "type": "newline" },
        { "type": "short_text", "name": "user_phone_number", "text_field_type": "number", "characters": 11, "mask": "(###) ###-####" }
      ]
    }
    """
    And the response status should be "200"

  Scenario:
    When I send a POST request to "/api/workflows/auth/prompts" with the following:
    """
    {
      "facts": {
        "user_phone_number": "6505294962"
      }
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "confirmation",
      "text": "Please enter the 4 digit number that was just sent to your phone.\n{{?user_confirmation_token}}",
      "parts": [
        { "type": "text", "content": "Please enter the 4 digit number that was just sent to your phone." },
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
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "thankyou",
      "text": "Thank you! Welcome to the application.{{?auth_token}}",
      "parts": [
        { "type": "text", "content": "Thank you!" },
        { "type": "text", "content": " Welcome to the application." },
        { "type": "hidden", "name": "auth_token", "value": "1234" }
      ]
    }
    """
