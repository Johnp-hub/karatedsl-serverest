Feature: Eliminación de Usuarios

  Background:
    * url baseUrl

  Scenario: Borrar un usuario del sistema (Positivo)
    * def setup = call read('user-service.feature@create')
    Given path 'usuarios', setup.userId
    When method delete
    Then status 200
    And match response.message == 'Registro excluído com sucesso'

  Scenario: Intentar eliminar un ID inexistente (Negativo)
    Given path 'usuarios', 'NON_EXISTENT_ID1'
    When method delete
    Then status 200
    And match response.message == 'Nenhum registro excluído'