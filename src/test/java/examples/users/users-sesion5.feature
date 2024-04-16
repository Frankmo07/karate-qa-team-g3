Feature: Funcionalidad de Users

  Background:
    * def responseLogin = call read("login.feature@Login")
    * def token = responseLogin.authToken
    * url "https://reqres.in/"
    * header Authorization = "Bearer" + token

    Scenario: Caso 1
      Given path "/api/users/"
      And request {"name": "morpheus", "job":"leader"}
      When method post
      Then status 201

  Scenario: Caso 3 - Actualizar Usuario
        * def id = "2"
      And path "/api/users/" +id
      And request read('body.json')
      When method patch
      Then status 200
      And match responseType =="json"
      And match $.name == "morpheus"
      And match $.job == "zion resident"

  Scenario: Caso 4 - Crear post con Json en variable
    * def body =
    """
    {
      'name': 'morpheus',
      'job': 'leader'
    }
    """
      And path "/api/users/"
      And request body
      When method post
      Then status 201
        * print response
      And match response == read ('estructuraresponse2.json')
