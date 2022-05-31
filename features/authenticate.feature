@api @authenticate
Feature: User Authentication
  As an API
  In order to manage data with the system
  I want to abe able to authenticate

  Scenario: authenticate with email and password
    Given I am a registered api user
    When I send a POST request for "/api/v1/sessions/digest" as JSON
    And the body should be the user access and refresh tokens