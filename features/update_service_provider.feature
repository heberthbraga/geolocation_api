@api @update-service-provider
Feature: Update Service Provider
  As an API
  In order to manage a service provider
  I want to update a service provider

  Scenario: update a service provider with JSON payload
    Given I am a valid "admin" user
    And I send and accept JSON
    And I send an authorization token
    When I send a PUT request to update a service provider for "/api/v1/service_providers/:id"
    Then then the update service provider response have a "200" status
    And the JSON response should be an updated service provider