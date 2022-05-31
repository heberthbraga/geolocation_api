@api @retrieve-geolocation
Feature: Retrieve Geolocation By Lookup Address
  As an API
  In order to gather geolocation data for a given service provider
  I want to retrieve a geolocation data

  Scenario: add geolocation data as JSON
    Given I am a valid "api" user
    And I send and accept JSON
    And I send an authorization token
    When I send a GET request to retrieve a geolocation for "/api/v1/geolocations/:lookup_address"
    Then then the geolocation get response should be "200"
    And the JSON response should be an existing geolocation data