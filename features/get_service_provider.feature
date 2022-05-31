@api @get-service-provider
Feature: Get Service Provider
  As an API
  In order to view or modify a service provider
  I want to retrieve a service provider

  Scenario: retrieve a service provider as JSON
    Given I am a valid "admin" user
    And I send and accept JSON
    And I send an authorization token
    When I send a GET request to retrieve service provider for "/api/v1/service_providers/:id"
    Then then the retrieve service provider response should be "200"
    And the JSON response should be a service provider for given id