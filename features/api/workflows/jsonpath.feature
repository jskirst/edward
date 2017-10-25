Feature: JSONPath

  Background:
    Given I am Json Path
    And I send and accept JSON

  Scenario: Steps can return data parsed from callout response JSON with JSONPath
    When I send a POST request to "/api/workflows/jsonpath/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "jsonpath",
      "text": "Today's weather is {{$.weather.days[0].summary}}.",
      "parts": [
        { "type": "text", "content": "Today's weather is " },
        { "type": "text", "content": "sunny" },
        { "type": "text", "content": "." }
      ]
    }
    """

