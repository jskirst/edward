Feature: Links

  Background:
    Given I am Embedded Link
    And I send and accept JSON

  Scenario: Pass attributes along with value
    When I send a POST request to "/api/workflows/embeddedlink/prompts" with the following:
    """
    {
      "facts": { "link1": "true" }
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "embeddedlink",
      "text": "This {{#'is a link'[href=/#stepBack]}}",
      "parts": [
        { "type": "text", "content": "This" },
        { "type": "link", "content": "is a link", "href": "/#stepBack" }
      ]
    }
    """
    And the response status should be "201"

  Scenario: Link with click event forward
    When I send a POST request to "/api/workflows/embeddedlink/prompts" with the following:
    """
    {
      "facts": { }
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "clickforward",
      "text": "Click{{#'forward'[href=#][click=step_forward]}}{{?forward=true}}",
      "parts": [
        { "type": "text", "content": "Click" },
        { "type": "link", "content": "forward", "href": "#", "click": "step_forward" },
        { "type": "hidden", "name": "forward", "value": "true" }
      ]
    }
    """
    And the response status should be "201"

  Scenario: Link with click event
    When I send a POST request to "/api/workflows/embeddedlink/prompts" with the following:
    """
    {
      "facts": { "forward": "true" }
    }
    """
    Then the JSON response should be:
    """
    {
      "token": "clickback",
      "text": "Click{{#'back'[href=#][click=step_back]}}",
      "parts": [
        { "type": "text", "content": "Click" },
        { "type": "link", "content": "back", "href": "#", "click": "step_back" }
      ]
    }
    """
    And the response status should be "201"

