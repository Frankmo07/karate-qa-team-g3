Feature: Ejercicios Clase 02

  Scenario: Caso 1 - Consultar usuario por id
    Given url "https://reqres.in"
    And path "/api/users/2"
    When method get
    Then status 200
  Scenario: Caso 2 - Consultar usuario por id
    * def id = 1
    Given url "https://reqres.in"
    And path "/api/users/" + id
    When method get
    Then status 200
    * print response
  Scenario: Caso 3 - Consultar usuario por id
    * def id = 4
    Given url "https://reqres.in"
    And path "/api/users/" + id
    When method get
    Then status 200
    And match response.data.id == id
    * print response.data.last_name

  Scenario: Caso 4 - REGISTRAR USUARIO
    Given url "https://reqres.in"
    And path "/api/register"
    And request { "email": "eve.holt@reqres.in","password": "pistol" }
    When method post
    Then status 200

  Scenario Outline: Caso 5 - REGISTRAR USUARIO
    * def body = { "email": "<email>","password": "<password>" }
    Given url "https://reqres.in"
    And path "/api/register"
    And request body
    When method post
    Then status 200
    And match response.id == '#notnull'

    Examples:
    | email | password|
    |eve.holt@reqres.in| pistol|



  Scenario Outline: Caso 6 - REGISTRAR USUARIO
    * def body =
     """
        {
         "email": <email>,
          "password": <password>
        }
     """
    Given url "https://reqres.in"
    And path "/api/register"
    And request body
    When method post
    Then status 200
    And match response.id == '#notnull'

    Examples:
      | email | password|
      |eve.holt@reqres.in| pistol|

    Scenario: Caso 7 - Actualizar Usuario
      Given url "https://reqres.in"
      And path "/api/users/2"
      And request {"name": "morpheus","job": "zion resident"}
      When method put
      Then status 200

  Scenario: Caso 8 - Actualizar Usuario 2
    * def name = "morpheus"
    Given url "https://reqres.in"
    And path "/api/users/2"
    And request {"name": "morpheus","job": "zion resident"}
    When method put
    Then status 200
    And match response.name == name

  Scenario: Caso 9 - Eliminar Usuario
    * def id = "2"
    Given url "https://reqres.in"
    And path "/api/users/" + id
    When method delete
    Then status 204

  Scenario: Caso 10 - Actualizar Usuario 3
    * def id = "2"
    Given url "https://reqres.in"
    And path "/api/users/" +id
    And  form field name = "morpheus"
    And  form field job = "zion resident"
    When method put
    Then status 200
    And match responseType =="json"
    And match $.name == "morpheus"
    And match $.job == "zion resident"

  Scenario: Caso 11 - Actualizar Usuario 4
    * def id = "2"
    Given url "https://reqres.in"
    And path "/api/users/" +id
    And request read('body.json')
    When method put
    Then status 200
    And match responseType =="json"
    And match $.name == "morpheus"
    And match $.job == "zion resident"