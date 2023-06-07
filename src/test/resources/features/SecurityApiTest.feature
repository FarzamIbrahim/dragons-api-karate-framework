@smoke @Regression
Feature: API Test Security Section

 Background: Setup Request URL
   Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
 
  Scenario: Create token with walid username and password
    #prepare request
    And request {"username": "supervisor","password": "tek_supervisor"}
    #send request
    When method post
    #validation response
    Then status 200
    And print response

  #Scenario 1:
  # endpoint = /api/token
  # if yuo send wrong username you should get 400 Status code
  #and API Response message "User not found"
  Scenario: Validate token with Invalid username
  #Given prepare request
  And request {"username": "wrongusername","password": "tek_supervisor"}
  #When send request
  When method post
  #Then Validate response
  Then status 400
  And print response
  And assert response.errorMessage == "User not found"
  
  #Scenario 2:
  #endpoint = /api/token 
  #if you send correct username and wrong password,
  #you should see 400 Bad Request and errorMessage Password not match
  #And "httpStatus": "BAD_REQUEST"
    #Given prepare request
    Scenario: Validate token with Valid username and Invalid password
  And request {"username": "supervisor","password": "Wrong_password"}
    #When send request
  When method post
  #Then Validate response
  Then status 400
  And print response
  And assert response.errorMessage == "Password Not Matched"
  And assert response.httpStatus == "BAD_REQUEST"
  
    
  
