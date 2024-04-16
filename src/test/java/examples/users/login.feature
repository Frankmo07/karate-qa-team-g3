Feature: Inicio de sesion

    @Login
    Scenario: Login exitoso
      Given url "https://reqres.in/"
      And path "/api/login"
      And request {"email": "eve.holt@reqres.in","password": "cityslicka"}
      When  method post
      Then status 200
      And match response.token == '#string'
       * def authToken = response.token