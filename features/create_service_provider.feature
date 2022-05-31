@api @create-service-provider
Feature: Create Service Provider
  As an API
  In order to gather geolocation data with different service providers
  I want to create a service provider

  Scenario: create a service provider with JSON payload
    Given I am a valid "admin" user
    And I send and accept JSON
    And I send an authorization token
    When I send a POST request for "/api/v1/service_providers"
    Then then the create service provider response have a "200" status
    And the body should be a new service provider JSON element