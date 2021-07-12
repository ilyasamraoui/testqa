Feature: WSO2 Identity Provider

  Background:
  * url "https://idp-dev.afs.socgen"
  
  Scenario: Authenticating with grant_type password should succeed and return valid tokens
    Given   path "/oauth2/token"
    And     header Authorization = "Basic RFFrVGNOaFVnbXhWU2NqR2kzczJjaGJUMTVNYTpZVEQzZHExVHFXcUFlYXV3emZwTTZRenlWNk1h"
    And     form field grant_type = "password"
    And     form field username = "BF0000005"
    And     form field password = "11223344"
    And     form field scope = "openid scim2"
    When    method POST
    Then    status 200
    And     match response == { access_token: '##string', refresh_token: '##string', scope: 'openid', id_token: '##string', token_type: 'Bearer', expires_in: '#number' }
    

