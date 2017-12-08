Feature: Steps API

  Background:
    Given I am Ragnar Lothbrok
    And I send and accept JSON

  Scenario: Create inline step with multiple answers
    When I send a POST request to "/api/workflows/abc/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "intro",
      "text": "My first name is {{?user_first_name}}, and my last name is {{?user_last_name}}, and I am {{?user_age[min=21][max=100]}} years old. Generally I prefer {{?user_style_preference}} wines.",
      "cta": "next",
      "parts": [
        { "type": "text", "content": "My" },
        { "type": "text", "content": "first" },
        { "type": "text", "content": "name" },
        { "type": "text", "content": "is" },
        { "type": "short_text", "name": "user_first_name", "text_field_type": "text", "characters": 8 },
        { "type": "punctuation", "content": "," },
        { "type": "text", "content": "and" },
        { "type": "text", "content": "my" },
        { "type": "text", "content": "last" },
        { "type": "text", "content": "name" },
        { "type": "text", "content": "is" },
        { "type": "short_text", "name": "user_last_name", "text_field_type": "text", "characters": 10 },
        { "type": "punctuation", "content": "," },
        { "type": "text", "content": "and" },
        { "type": "text", "content": "I" },
        { "type": "text", "content": "am" },
        { "type": "short_text", "name": "user_age", "characters": 3, "text_field_type": "number", "min": "21", "max": "100" },
        { "type": "text", "content": "years" },
        { "type": "text", "content": "old." },
        { "type": "text", "content": "Generally" },
        { "type": "text", "content": "I" },
        { "type": "text", "content": "prefer" },
        {
          "type": "select",
          "name": "user_style_preference",
          "options": [
          { "token": "redoption", "text": "red", "value": "red" },
          { "token": "whiteoption", "text": "white", "value": "white" }
          ]
        },
        { "type": "text", "content": "wines." }
      ]
    }
    """

  Scenario: Create inline step with a single option answer and a user fact
    When I send a POST request to "/api/workflows/abc/prompts" with the following:
    """
    {
      "facts": {
        "user_first_name": "Giles",
        "user_last_name": "Rotherbrok",
        "user_style_preference": "white"
      }
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "hello",
      "text": "Hello {{@user_first_name}}, would you like any recommendations?\n{{?user_desires_recommendations}}",
      "cta": "next",
      "parts": [
        { "type": "text", "content": "Hello" },
        { "type": "text", "content": "Giles" },
        { "type": "punctuation", "content": "," },
        { "type": "text", "content": "would" },
        { "type": "text", "content": "you" },
        { "type": "text", "content": "like" },
        { "type": "text", "content": "any" },
        { "type": "text", "content": "recommendations?" },
        { "type": "newline" },
        {
          "type": "select",
          "name": "user_desires_recommendations",
          "options": [
          { "token": "yesoption", "text": "Yes", "value": "yes" },
          { "token": "nooption", "text": "No", "value": "no" }
          ]
        }
      ]
    }
    """

  Scenario: Conditions can process a negative value
    When I send a POST request to "/api/workflows/abc/prompts" with the following:
    """
    {
      "facts": {
        "user_first_name": "Giles",
        "user_last_name": "Rotherbrok",
        "user_style_preference": "white",
        "user_desires_recommendations": "no"
      }
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "finethen",
      "text": "Well, fine then.",
      "cta": "next",
      "parts": [
        { "type": "text", "content": "Well," },
        { "type": "text", "content": "fine" },
        { "type": "text", "content": "then." }
      ]
    }
    """

  Scenario: Create step with no answers and lots of breaking punctuation
    When I send a POST request to "/api/workflows/abc/prompts" with the following:
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
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "really",
      "text": "Really? Splendid! Superb. I recommend the {{@recommendation}}.",
      "cta": "next",
      "parts": [
        { "type": "text", "content": "Really?" },
        { "type": "text", "content": "Splendid!" },
        { "type": "text", "content": "Superb." },
        { "type": "text", "content": "I" },
        { "type": "text", "content": "recommend" },
        { "type": "text", "content": "the" },
        { "type": "text", "content": "Russian River Chardonnay" },
        { "type": "punctuation", "content": "." }
      ]
    }
    """

  Scenario: Create step with no answers and lots of breaking punctuation
    When I send a POST request to "/api/workflows/abc/prompts" with the following:
    """
    {
      "facts": {
        "user_first_name": "Giles",
        "user_last_name": "Rotherbrok",
        "user_style_preference": "red",
        "user_desires_recommendations": "yes"
      }
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "recommendation",
      "text": "I recommend the {{@recommendation}}.\n{{?recommendation}}",
      "cta": "next",
      "parts": [
        { "type": "text", "content": "I" },
        { "type": "text", "content": "recommend" },
        { "type": "text", "content": "the" },
        { "type": "text", "content": "Pinot Noir" },
        { "type": "punctuation", "content": "." },
        { "type": "newline" },
        { "type": "hidden", "name": "recommendation", "value": "Pinot Noir" }
      ]
    }
    """
