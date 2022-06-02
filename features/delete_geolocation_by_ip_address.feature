@api @delete-geolocation
Feature: Delete Geolocation By Lookup Address
  As an API
  In order to manager geolocation data for a given service provider
  I want to delete a geolocation data

  Scenario: add geolocation data as JSON
    Given I am a valid "api" user
    And I send and accept JSON
    And I send an authorization token
    When I send a DELETE request to delete a geolocation for "/api/v1/geolocations/:lookup_address"
    Then then the geolocation delete response should be "200"
    And the JSON response should be a deleted geolocation data ref