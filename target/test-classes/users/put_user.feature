Feature: Actualización de Usuarios

  Background:
    * url baseUrl
    * def service = 'user-service.feature'

  Scenario: Modificar datos de usuario exitosamente (Positivo)
    * def creator = call read(service + '@create')
    * def userId = creator.userId
    * def originalEmail = creator.usedEmail
    * def updateData = 
    """
    { 
      "nome": "Nombre Editado", 
      "email": "#(originalEmail)", 
      "password": "newpassword123", 
      "administrador": "true" 
    }
    """
    Given path 'usuarios', userId
    And request updateData
    When method put
    Then status 200
    And match response.message == 'Registro alterado com sucesso'

  Scenario: Error al actualizar con email ya en uso por otro (Negativo)
    * def userA = call read(service + '@create')
    * def userB = call read(service + '@create')
    * def conflictData = { "nome": "Fail", "email": "#(userB.payload.email)", "password": "123", "administrador": "true" }
    Given path 'usuarios', userA.userId
    And request conflictData
    When method put
    Then status 400
    And match response.message == 'Este email já está sendo usado'