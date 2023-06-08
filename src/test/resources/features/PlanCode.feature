@Regression
Feature: Plan Code Feature

  Background: Setup api tests and get token
    * def result = callonce read('generateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Get all plan code api
    Given path "api/plans/get-all-plan-code"
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert response[0].planExpired == false
    And assert response[1].planExpired == false
    And assert response[2].planExpired == false
    And assert response[3].planExpired == false
