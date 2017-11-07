Feature: Attributes

  Background:
    Given I am Attri Butes
    And I send and accept JSON

  Scenario: Pass attributes along with object
    When I send a POST request to "/api/workflows/attributes/prompts" with the following:
    """
    {
    "facts": { "how_great": "Super great." }
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "attributes",
      "text": "How great?{{@how_great[bold=true]}}",
      "parts": [
        { "type": "text", "content": "How" },
        { "type": "text", "content": "great?" },
        { "type": "text", "content": "Super great.", "bold": "true" }
      ]
    }
    """
    And the response status should be "201"

  Scenario: Pass multiple attributes along with object
    When I send a POST request to "/api/workflows/attributes/prompts" with the following:
    """
    {
    "facts": { "color": "blue" }
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "color",
      "text": "Color?{{@color[font-style=Times New Roman][bold=true]}}",
      "parts": [
        { "type": "text", "content": "Color?" },
        { "type": "text", "content": "blue", "bold": "true", "font-style": "Times New Roman" }
      ]
    }
    """
    And the response status should be "201"
