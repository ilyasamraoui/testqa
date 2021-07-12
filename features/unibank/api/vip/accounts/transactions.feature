Feature: Transactions
  Background: 
    Given url 'https://hvip-f-cba.dns21.socgen/sidecar/graphql'
    * def accessDataUrl = urlBase + "test-data/unibank/api/auth/"
    * def transactionsTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/vip/accounts/account-list-data.yaml')
    * def transactionsTestData = read(transactionsTestDataFile)
    * def generateRequest = 
    """
    function() {
      return `
      query {transactions(input: { accountNumber: "01073600601", startDate: "2000-09-08", endDate: "2020-12-30", minimumAmount: "-1000000", maximumAmount: "5000000", transactionType: DEPOSIT,amount: "-11871.0" })
      {
          amount
          balanceAfterTransaction
          bookingDate
          cardNumber
          counterpartyAccount
          currency
          currencyRate
          message
          originalCurrency
          valueDate
          typeDescription
          transactionDate
          reference
          status
          paymentDate
          ownMessage
          originalCurrencyAmount
        }
      }
      `
    }
    """
  Scenario Outline: Transactions OK [<name>]
    Given request generateRequest()
    * def accessTokenFeatureFile = fileUtils.downloadFile(urlBase + 'features/unibank/api/auth/get-access-token.feature')
    * def accessTokenFeature = call read(accessTokenFeatureFile) {accessDataUrl: #(accessDataUrl + "<entity>-access-token-data.yaml")}
    And header Authorization = 'Bearer ' + accessTokenFeature.response.id_token
    When method POST
    Then status 200
    
    Examples:
    | transactionsTestData.entities |
