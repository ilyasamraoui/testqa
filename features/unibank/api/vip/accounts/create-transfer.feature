Feature: Create Transfer
  Background: 
    Given url 'https://hvip-f-cba.dns21.socgen/sidecar/graphql'
    * def accessDataUrl = urlBase + "test-data/unibank/api/auth/"
    * def createTransferTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/vip/accounts/account-list-data.yaml')
    * def createTransferTestData = read(createTransferTestDataFile)
    * def generateRequest = 
    """
    function() {
      return `
      mutation virement{createTransfer(
          input:
          {
            amount:15.0000,
            debitAccountHolder:"Jhon Doe",
            debitAccountNumber:"01073600601",
            creditAccount:"01073601202",
            note:" 127 XOF from Jhon Doe to XXX"
            
          }
          )
          {
            reference,mutation virement{createTransfer(
          input:
          {
            amount:15.0000,
            debitAccountHolder:"Jhon Doe",
            debitAccountNumber:"01073600601",
            creditAccount:"01073601202",
            note:" 127 XOF from Jhon Doe to XXX"
            
          }
          )
          {
            reference,
            status
          }
        }
            status
          }
        }
      `
    }
    """
  Scenario Outline: Create Transfer OK [<name>]
    Given request generateRequest()
    * def accessTokenFeatureFile = fileUtils.downloadFile(urlBase + 'features/unibank/api/auth/get-access-token.feature')
    * def accessTokenFeature = call read(accessTokenFeatureFile) {accessDataUrl: #(accessDataUrl + "<entity>-access-token-data.yaml")}
    And header Authorization = 'Bearer ' + accessTokenFeature.response.id_token
    When method POST
    Then status 200
    
    Examples:
    | createTransferTestData.entities |
