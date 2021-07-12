Feature: OnboardUser

  Scenario Outline: Users.onboardUser should succeed (via <name>)
    * text onboardUserMutation =
      """
      mutation onboardUser($input: OnboardUserRequest){ 
          onboardUser(input: $input) { 
            deviceActivated, language, publicKey, secret, 
            terms{ body, category, creationDate, format, language, modificationDate, notPublished, order, space, status, tags, title, type, urn, version }, 
            termspprovalRequired 
          } 
      }
      """
    Given   url "https://idp-dev.afs.socgen/oauth2/token"
    And     header Authorization = "Basic RFFrVGNOaFVnbXhWU2NqR2kzczJjaGJUMTVNYTpZVEQzZHExVHFXcUFlYXV3emZwTTZRenlWNk1h"
    And     form field grant_type = "password"
    And     form field username = "BFXXXXXXX"
    And     form field password = "11223344"
    And     form field scope = "openid scim2"
    When    method POST
    Then    status 200
    And     match response == { access_token: '##string', refresh_token: '##string', scope: 'openid', id_token: '##string', token_type: 'Bearer', expires_in: '#number' }
    And     print response.id_token
    And     print response.access_token
    And     url "<endpoint>"
    And     header X-OperationId = "onboardUser"
    And     header Authorization = 'Bearer ' + response.access_token
    And     header X-JWT-Assertion = response.id_token
    And     request { query: '#(onboardUserMutation)', variables: {input: {}} }
    When    method POST
    Then    status 200
    And     match response.data.onboardUser == { deviceActivated: '#boolean', termspprovalRequired: '#boolean', language: '#string', publicKey: '#string', secret: '#string', terms: '#ignore' }

    Examples:
    | endpoint                                                  | name         |
    | https://dvip-cba.dns21.socgen/users/graphql               | api          |
    | https://dvip-cba.dns21.socgen/sidecar/graphql             | sidecar      |
    | https://dvipgwt-ext.dns21.socgen/graphql/1.0/operations   | gateway      |
