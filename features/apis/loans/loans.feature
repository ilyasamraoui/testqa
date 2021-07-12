Feature: Loans.loans

  Scenario Outline: Loans listing should succeed (via <name>)
    * text graphqlQuery =
      """
      query loans($input: GetLoanListRequest){ 
        loans(input: $input) { 
          amendmentNumber, amount, branchCode, codeType, currency, customerNumber, durationInMonths, establishmentDate, 
          fileNumber, installmentAmount, installmentPeriods, interestRate, lastInstallmentDate, orderNumber, processingCode, remainingAmount, type 
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
    And     header X-OperationId = "loans"
    And     header Authorization = 'Bearer ' + response.access_token
    And     header X-JWT-Assertion = response.id_token
    And     request { query: '#(graphqlQuery)', variables: {input: {}} }
    When    method POST
    Then    status 200
    And     match response == { data: '#object' }

    Examples:
    | endpoint                                                  | name         |
    | https://dvip-cba.dns21.socgen/loans/graphql            | direct       |
    | https://dvip-cba.dns21.socgen/sidecar/graphql             | sidecar      |
    | https://dvipgwt-ext.dns21.socgen/graphql/1.0/operations   | gateway      |
