Feature: JSONPath

  Background:
    Given the "Json Path" workflow exists
    And I send and accept JSON

  Scenario: Steps can return data parsed from callout response JSON with JSONPath
    When I send a POST request to "/api/workflows/jsonpath/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "jsonpath",
      "text": "Today's weather is {{$.weather.days[0].summary}}.",
      "parts": [
        { "type": "text", "content": "Today's" },
        { "type": "text", "content": "weather" },
        { "type": "text", "content": "is" },
        { "type": "text", "content": "sunny" },
        { "type": "punctuation", "content": "." }
      ]
    }
    """

  Scenario: Steps can use return data parsed from callout response JSON has hidden value
    When I send a POST request to "/api/workflows/jsonpath/prompts" with the following:
    """
    {
    "facts": { "hidden": true }
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "jsonpathhidden",
      "text": "Today's weather is fine.{{&weather=$.weather.days[0].summary}}",
      "parts": [
        { "type": "text", "content": "Today's" },
        { "type": "text", "content": "weather" },
        { "type": "text", "content": "is" },
        { "type": "text", "content": "fine." },
        { "type": "hidden", "name": "weather", "value": "sunny" }
      ]
    }
    """

