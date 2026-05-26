@ignore
Feature: User Service Actions

  Background:
    * url baseUrl

  @create
  Scenario: Create User
    * def random = Math.floor(Math.random() * 10000)
    * def userEmail = 'qa.test' + random + '@gmail.com'
    
    * def payload = 
    """
    {
      "nome": "User QA",
      "email": "#(userEmail)",
      "password": "123",
      "administrador": "true"
    }
    """
    * def finalPayload = karate.get('userPayload', payload)
    Given path 'usuarios'
    And request finalPayload
    When method post
    Then status 201
    * def userId = response._id
  * def usedEmail = finalPayload.email

  @delete
  Scenario: Delete User
    # Requiere que le pasemos 'deleteId' al llamar a este scenario
    Given path 'usuarios', deleteId
    When method delete
    Then status 200