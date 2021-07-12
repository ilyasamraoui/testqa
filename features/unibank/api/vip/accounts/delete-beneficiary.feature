Feature: Delete Beneficiary
  Background: 
    Given url 'https://hvip-f-cba.dns21.socgen/sidecar/graphql'
    * def accessDataUrl = urlBase + "test-data/unibank/api/auth/"
    * def deleteBeneficiaryTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/vip/accounts/account-list-data.yaml')
    * def deleteBeneficiaryTestData = read(deleteBeneficiaryTestDataFile)
    * def generateRequest = 
    """
    function() {
      return `
      mutation { deleteBeneficiary(input:
      {
      urn: "urn-bf-beneficiary-skycrtxb0u3l"
      })
      }
      `
    }
    """
  Scenario Outline: Delete Beneficiary OK [<name>]
    Given request generateRequest()
    * def accessTokenFeatureFile = fileUtils.downloadFile(urlBase + 'features/unibank/api/auth/get-access-token.feature')
    * def accessTokenFeature = call read(accessTokenFeatureFile) {accessDataUrl: #(accessDataUrl + "<entity>-access-token-data.yaml")}
    And header Authorization = 'Bearer ' + accessTokenFeature.response.id_token
    When method POST
    Then status 200
    
    Examples:
    | deleteBeneficiaryTestData.entities |
