Feature: Steps API

  Background:
    Given I am Ragnar Lothbrok
    And I send and accept JSON

  Scenario: Create inline step with multiple answers
    When I send a POST request to "/api/workflows/abc/steps" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "text": "My first name is {{?user_first_name}}, and my last name is {{?user_last_name}}. Generally I prefer {{?user_style_preference}} wines.",
      "parts": [
        { "type": "text", "content": "My first name is " },
        { "type": "short_text", "name": "user_first_name" },
        { "type": "text", "content": "," },
        { "type": "text", "content": " and my last name is " },
        { "type": "short_text", "name": "user_last_name" },
        { "type": "text", "content": "." },
        { "type": "text", "content": " Generally I prefer " },
        {
          "type": "select",
          "name": "user_style_preference",
          "options": [
            { "text": "red", "value": "red" },
            { "text": "white", "value": "white" }
          ]
        },
        { "type": "text", "content": " wines." }
      ]
    }
    """

  Scenario: Create inline step with a single option answer and a user fact
    When I send a POST request to "/api/workflows/abc/steps" with the following:
    """
    {
      "facts": {
        "user_first_name": "Giles",
        "user_last_name": "Rotherbrok",
        "user_style_preference": "white"
      }
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "text": "Hello {{@user_first_name}}, would you like any recommendations?\n{{?user_desires_recommendations}}",
      "parts": [
        { "type": "text", "content": "Hello " },
        { "type": "text", "content": "Giles" },
        { "type": "text", "content": "," },
        { "type": "text", "content": " would you like any recommendations?\n" },
        {
          "type": "select",
          "name": "user_desires_recommendations",
          "options": [
            { "text": "Yes", "value": "yes" },
            { "text": "No", "value": "no" }
          ]
        }
      ]
    }
    """

  Scenario: Create step with no answers
    When I send a POST request to "/api/workflows/abc/steps" with the following:
    """
    {
      "facts": {
        "user_first_name": "Giles",
        "user_last_name": "Rotherbrok",
        "user_style_preference": "white",
        "user_desires_recommendations": "yes"
      }
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "text": "I recommend the {{@recommendation}}.",
      "parts": [
        { "type": "text", "content": "I recommend the " },
        { "type": "text", "content": "Russian River Chardonnay" },
        { "type": "text", "content": "." }
      ]
    }
    """
