@api @delete-service-provider
Feature: Delete Service Provider
  As an API
  In order to not use a service provider anymore
  I want to remove the service provider

  Scenario: remove a service provider
    Given I am a valid "admin" user
    And I send and accept JSON
    And I send an authorization token
    When I send a DELETE request to remove a service provider for "/api/v1/service_providers/:id"
    Then then the delete service provider response should be "200"
    And the service provider is not stored in the system