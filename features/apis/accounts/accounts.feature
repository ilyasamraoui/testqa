Feature: Accounts.Accounts

  Scenario Outline: Accounts listing should succeed (via <name>)
    * text graphqlQuery =
      """
      query accounts($input: GetAccountListRequest){ 
        accounts(input: $input) { 
          accountAlias, accountCategory, accountClass, accountId, accountName, accountNumber, 
          accountNumbers{ scheme, type, value }, 
          accountType, accountingBalance, availableBalance, 
          balances{ currency, month, name, type, value, year }, 
          bank{ code, country, name, swift }, 
          branch{ code, designation }, 
          classAndProduct, closedAccount, country, creditAccountStatus, creditAllowed, 
          currency{ alphaCode, numericCode }, 
          customerName, customerNumber, debitAccountStatus, debitAllowed, debitCreditIndicator, downloadRibStatus, downloadStatementStatus, 
          gauge{ accountId, activationStatus, highBalance, lowBalance }, 
          iban, ibanKey, jointAccount, lastCreditDate, lastDebitDate, lastMovementDate, latestTransactionBookingDate, openingDate, 
          oppositions{ code, endDate, oppositionEndReason, oppositionReason, startDate, status }, 
          overdraftLimit, product, realtimeBalance, rib, ribKey, status, upcomingBalance 
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
    And     header X-OperationId = "accounts"
    And     header Authorization = 'Bearer ' + response.access_token
    And     header X-JWT-Assertion = response.id_token
    And     request { query: '#(graphqlQuery)', variables: {input: {}} }
    When    method POST
    Then    status 200
    And     print response.data
    And     match response.data == { accounts: '#notnull' }

    Examples:
    | endpoint                                                  | name         |
    | https://dvip-cba.dns21.socgen/accounts/graphql            | direct       |
    | https://dvip-cba.dns21.socgen/sidecar/graphql             | sidecar      |
    | https://dvipgwt-ext.dns21.socgen/graphql/1.0/operations   | gateway      |
