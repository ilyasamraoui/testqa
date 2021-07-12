Feature: Add Beneficiary
  Background:
    Given url 'https://hvip-f-cba.dns21.socgen/sidecar/graphql'
    * def accessDataUrl = urlBase + "test-data/unibank/api/auth/"
    * def addBeneficiaryTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/vip/accounts/account-list-data.yaml')
    * def addBeneficiaryTestData = read(addBeneficiaryTestDataFile)
    * def generateRequest = 
    """
    function() {
      return `
      mutation createBeneficiaryRIB
      {
        addBeneficiary(input:
          {
          accountNumber:"BF0740100100210230010162",
          accountScheme:RIB,
          name:"jhon doe",
          type:GENERIC
        })
        {
          urn,
          accountNumber,
          type,
          accountScheme,
          name
        }
      }
      `
    }
    """
  Scenario Outline: Add Beneficiary OK [<name>]
    Given request generateRequest()
    * def accessTokenFeatureFile = fileUtils.downloadFile(urlBase + 'features/unibank/api/auth/get-access-token.feature')
    * def accessTokenFeature = call read(accessTokenFeatureFile) {accessDataUrl: #(accessDataUrl + "<entity>-access-token-data.yaml")}
    And header Authorization = 'Bearer ' + accessTokenFeature.response.id_token
    When method POST
    Then status 200
    
    Examples:
    | addBeneficiaryTestData.entities |
