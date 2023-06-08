@Regression
Feature: Random Account Creation

  Background: Setup Test Generate Token
    * def tokenFeature = callonce read('generateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account with Random Email
    # Call Java Class and Method with Karate.
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    And request
      """
      {
      "email": "#(autoEmail)",
      "firstName": "Ibrahim",
      "lastName": "Farzam",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "QA",
      "dateOfBirth": "1992-11-25"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
