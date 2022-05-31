@api @list-service-providers
Feature: List Service Providers
  As an API
  In order to gather geolocation data with different service providers
  I want to retrieve a list of service providers

  Scenario: retrieve all service providers as JSON
    Given I am a valid "admin" user
    And I send and accept JSON
    And I send an authorization token
    When I send a GET request for "/api/v1/service_providers"
    Then then the response should be "200"
    And the JSON response should be a service providers array with "1" service provider element