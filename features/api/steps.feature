Feature: Steps

  Background:
    Given I am Andy Developer
    And I send and accept JSON

  Scenario: System prevents access without api_key
    When I send a POST request to "/api/workflows/okayflow/steps?api_key=12345" with the following:
    """
    {
      "token": "newstep",
      "text": "okay text",
      "conditions": "real=",
      "cta": null,
      "cta_class": null,
      "cta_href": null,
      "callout": null,
      "callout_method": null,
      "callout_body": null
    }
    """
    Then the response status should be "401"
    And the JSON response should be:
    """
    {
      "error": "Request denied."
    }
    """

  Scenario: Create a step
    When I send a POST request to "/api/workflows/okayflow/steps?api_key=ABCDE" with the following:
    """
    {
      "token": "newstep",
      "text": "new text",
      "conditions": "new=",
      "cta": null,
      "cta_class": null,
      "cta_href": null,
      "callout": null,
      "callout_method": null,
      "callout_body": null
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "token": "newstep",
      "text": "new text",
      "conditions": "new=",
      "cta": null,
      "cta_class": null,
      "cta_href": null,
      "callout": null,
      "callout_method": null,
      "callout_body": null
    }
    """

  Scenario: Get a step
    When I send a GET request to "/api/workflows/okayflow/steps/okaystep?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "okaystep",
      "text": "okay text",
      "conditions": "hmm=",
      "cta": null,
      "cta_class": null,
      "cta_href": null,
      "callout": null,
      "callout_method": null,
      "callout_body": null
    }
    """

  Scenario: Get all steps
    When I send a GET request to "/api/workflows/okayflow/steps?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    [
      {
        "token": "okaystep",
        "text": "okay text",
        "conditions": "hmm=",
        "cta": null,
        "cta_class": null,
        "cta_href": null,
        "callout": null,
        "callout_method": null,
        "callout_body": null
      }
    ]
    """

  Scenario: Patch a step
    When I send a PATCH request to "/api/workflows/okayflow/steps/okaystep?api_key=ABCDE"
    """
    {
      "token": "updatedstep",
      "text": "new text",
      "conditions": "ahh=",
      "cta": null,
      "cta_class": null,
      "cta_href": null,
      "callout": null,
      "callout_method": null,
      "callout_body": null
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "updatedstep",
      "text": "new text",
      "conditions": "ahh=",
      "cta": null,
      "cta_class": null,
      "cta_href": null,
      "callout": null,
      "callout_method": null,
      "callout_body": null
    }
    """

  Scenario: Delete a step
    When I send a DELETE request to "/api/workflows/okayflow/steps/okaystep?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "token": "okaystep",
      "text": "okay text",
      "conditions": "hmm=",
      "cta": null,
      "cta_class": null,
      "cta_href": null,
      "callout": null,
      "callout_method": null,
      "callout_body": null
    }
    """
