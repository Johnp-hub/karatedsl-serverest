Feature: Listar Usuarios
  Background:
    * url baseUrl
    * def userSchema = read('user-schema.json')

  Scenario: Obtener lista completa y validar esquema
    Given path 'usuarios'
    When method get
    Then status 200
    And match each response.usuarios == userSchema.user