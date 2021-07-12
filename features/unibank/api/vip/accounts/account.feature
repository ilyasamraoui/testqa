Feature: Account
  Background: 
    Given url 'https://hvip-f-cba.dns21.socgen/sidecar/graphql'
    * def accessDataUrl = urlBase + "test-data/unibank/api/auth/"
    * def accountTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/vip/accounts/account-list-data.yaml')
    * yaml accountTestData = read(accountTestDataFile)
    * def generateRequest = 
    """
    function() {
      return `
      query: account {
        account(input: {accountNumber: "01073600601"}) {
          iban
          overdraftLimit
          realtimeBalance
          accountNumber
          ribKey
          ibanKey
          rib
          upcomingBalance
          accountCategory
          accountClass
          accountType
          product
          accountName
          bank{code, swift}
          country
          debitAccountStatus
          creditAccountStatus
          #downloadRibStatus
          #downloadStatementStatus
          accountClass
          balances{
            currency
            type
            value
            month
            year
          }
        }
      }
      `
    }
    """
  Scenario Outline: Account OK [<name>]
    Given request generateRequest()
    * def accessTokenFeatureFile = fileUtils.downloadFile(urlBase + 'features/unibank/api/auth/get-access-token.feature')
    * def accessTokenFeature = call read(accessTokenFeatureFile) {accessDataUrl: #(accessDataUrl + "<entity>-access-token-data.yaml")}
    And header Authorization = 'Bearer ' + accessTokenFeature.response.id_token
    When method POST
    Then status 200
    
    Examples:
    | accountTestData.entities |
