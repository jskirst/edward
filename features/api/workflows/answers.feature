Feature: Answers

  Background:
    Given I send and accept JSON

  Scenario: Answer with numbers in name
    Given the "Alpha Numeric" workflow exists
    When I send a POST request to "/api/workflows/alphanumeric/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the JSON response should be:
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
    And the response status should be "201"

  Scenario: Answers with default_value set in the step text should return that value
    Given the "Default Textvalue" workflow exists
    When I send a POST request to "/api/workflows/defaulttextvalue/prompts" with the following:
    """
    {
    "facts": {}
    }
    """
    Then the JSON response should be:
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
    And the response status should be "201"


  Scenario: Answers with default_value set should return them
    Given the "Default Value" workflow exists
    When I send a POST request to "/api/workflows/defaultvalue/prompts" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "201"
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

