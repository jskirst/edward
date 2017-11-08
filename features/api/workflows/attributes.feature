Feature: Attributes

  Background:
    Given I am Attri Butes
    And I send and accept JSON

  Scenario: Pass attributes along with value
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

  Scenario: Pass multiple attributes along with value
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

  Scenario: Pass attribute along with answer with default value
    When I send a POST request to "/api/workflows/attributes/prompts" with the following:
    """
    {
    "facts": { }
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "favoritecolor",
      "text": "Favorite color?{{?color='blue'[min=100]}}",
      "parts": [
        { "type": "text", "content": "Favorite" },
        { "type": "text", "content": "color?" },
        { "type": "short_text", "text_field_type": "text", "name": "color", "value": "blue", "min": "100" }
      ]
    }
    """
    And the response status should be "201"

  Scenario: Pass attribute with value along with answer with default value
    When I send a POST request to "/api/workflows/attributes/prompts" with the following:
    """
    {
      "facts": { "hue": "200" }
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "favoritehue",
      "text": "Favorite hue?{{?hue='200'[min=@hue]}}",
      "parts": [
        { "type": "text", "content": "Favorite" },
        { "type": "text", "content": "hue?" },
        { "type": "short_text", "text_field_type": "text", "name": "hue", "value": "200", "min": "200" }
      ]
    }
    """
    And the response status should be "201"
