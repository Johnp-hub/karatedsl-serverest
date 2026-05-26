Feature: Consulta de Usuario por ID

  Background:
    * url baseUrl
    * def schemas = read('user-schema.json')

  Scenario: Obtener detalles de usuario existente
    * def creator = call read('user-service.feature@create')
    Given path 'usuarios', creator.userId
    When method get
    Then status 200
    And match response == schemas.user

  Scenario: Error al buscar un ID que no existe
    Given path 'usuarios', 'IDINVALIDO123456'
    When method get
    Then status 400
    And match response == schemas.errorResponse
    And match response.message == 'Usuário não encontrado'