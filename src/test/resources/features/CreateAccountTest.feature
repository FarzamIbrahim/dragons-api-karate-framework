#Scenario 10:
#Endpoint = /api/accounts/add-primary-account.
#Status Code = 201
#Assert Email Address
#Notes:
#duplicate email not accepted
#For Gender and maritalStatus You have to use the Predefined values.
#Once you create Account validate database and take screenshot.
#FirstName and LastName should be your name.
#In Request body we don't need id and isNew field (you can remove them).
@Regression
Feature: Create Account Test

  Background: API Test Setup
    #callonce read is Karate Step to execute and read another feature file.
    #the result of callonce can store into new variable using def step.
    * def result = callonce read('generateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "email": "ibra700@gmail.com",
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
    And assert response.email == "ibra700@gmail.com"
    #Delete created account
    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = response.id
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
