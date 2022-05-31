@api @add-geolocation-address
Feature: Add Geolocation
  As an API
  In order to gather geolocation data for a given service provider
  I want to add a geolocation data

  Scenario: add geolocation data as JSON
    Given I am a valid "api" user
    And I send and accept JSON
    And I send an authorization token
    When I send a POST request to add geolocation for "/api/v1/geolocations" and a given ip address
    Then then the geolocation creation response should be "200"
    And the JSON response should be a geolocation data