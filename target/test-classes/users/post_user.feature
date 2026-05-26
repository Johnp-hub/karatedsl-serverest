Feature: Gestión de Registro de Usuarios

  Background:
    * url baseUrl
    * def schemas = read('user-schema.json')
    * def service = 'user-service.feature'

  Scenario: Registrar un nuevo usuario exitosamente (Positivo)
    * def randomTag = java.util.UUID.randomUUID().toString().substring(0, 8)
    * def uniqueEmail = 'user.' + randomTag + '@test.com'
    
    * def newUser = 
    """
    { 
      "nome": "John QA", 
      "email": "#(uniqueEmail)", 
      "password": "123", 
      "administrador": "true" 
    }
    """
    * def result = call read('user-service.feature@create') { userPayload: #(newUser) }
    Given path 'usuarios'
    And request newUser
    When method post
    And match result.responseStatus == 201
    And match result.response == { message: 'Cadastro realizado com sucesso', _id: '#string' }

  Scenario: Error al registrar usuario con email duplicado (Negativo)
    # 1. Creamos el primer usuario
    * def base = call read('user-service.feature@create')
    * def emailToDuplicate = base.usedEmail
    
    # 2. Intentamos registrar el SEGUNDO usuario con el MISMO email del primero

    Given path 'usuarios'
    And request
    """
    { 
      "nome": "Duplicate", 
      "email": "#(emailToDuplicate)", 
      "password": "123", 
      "administrador": "true" 
    }
    """
    When method post
    Then status 400
    And match response == schemas.errorResponse
    And match response.message == 'Este email já está sendo usado'