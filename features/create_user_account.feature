@api @create-service-provider
Feature: Create User Account
  As an API
  In order to gather geolocation data with different service providers
  I want to create an user account

  Scenario: create user account with JSON payload
    Given I am a not registered user
    When I send a POST request to create account for "/api/v1/accounts/create"
    Then then the create user account response have a "200" status
    And the body should be a new user account JSON element