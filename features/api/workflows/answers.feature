Feature: Answers

  Scenario: Answer with numbers in name
    Given I am Alpha Numeric
    When I send a POST request to "/api/workflows/alphanumeric/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "alphanumeric",
      "text": "Letter.{{?alpha_1}}",
      "parts": [
        { "type": "text", "content": "Letter." },
        { "type": "hidden", "name": "alpha_1" }
      ]
    }
    """

  Scenario: Answers with default_value set in the step text should return that value
    Given I am Default Textvalue
    When I send a POST request to "/api/workflows/defaulttextvalue/prompts" with the following:
    """
    {
    "facts": {}
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "defaulttextvalue",
      "text": "Default.{{?default_text_value='false'}}",
      "parts": [
        { "type": "text", "content": "Default." },
        { "type": "hidden", "name": "default_text_value", "value": "false" }
      ]
    }
    """

  Scenario: Answers with default_value set should return them
    Given I am Default Value
    When I send a POST request to "/api/workflows/defaultvalue/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "defaultvalue",
      "text": "Default.{{?default_value}}",
      "parts": [
        { "type": "text", "content": "Default." },
        { "type": "hidden", "name": "default_value", "value": "true" }
      ]
    }
    """
  Scenario: Answers with prefix and suffix should return them
    Given I am Suffix Prefix
    When I send a POST request to "/api/workflows/suffixprefix/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "suffixprefix",
      "text": "Suffix & Prefix.{{?suffix_prefix}}",
      "parts": [
        { "type": "text", "content": "Suffix & Prefix." },
        { "type": "short_text", "name": "suffix_prefix", "suffix": "dollars", "prefix": "$", "text_field_type": "text" }
      ]
    }
    """

