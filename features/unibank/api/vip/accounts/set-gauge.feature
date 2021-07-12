Feature: Set Gauge
  Background: 
    Given url 'https://hvip-f-cba.dns21.socgen/sidecar/graphql'
    * def accessDataUrl = urlBase + "test-data/unibank/api/auth/"
    * def setGaugeTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/vip/accounts/account-list-data.yaml')
    * def setGaugeTestData = read(setGaugeTestDataFile)
    * def generateRequest = 
    """
    function() {
      return `
      mutation
      {
        setGauge(input:
          {
          accountId:"01016.23855000601.XOF"
          lowBalance:2000
          highBalance:60000
          activationStatus : false
        })
        {
          accountId,
          highBalance,
          lowBalance,
          activationStatus,
        }
      }
      `
    }
    """
  Scenario Outline: Set Gauge OK [<name>]
    Given request generateRequest()
    * def accessTokenFeatureFile = fileUtils.downloadFile(urlBase + 'features/unibank/api/auth/get-access-token.feature')
    * def accessTokenFeature = call read(accessTokenFeatureFile) {accessDataUrl: #(accessDataUrl + "<entity>-access-token-data.yaml")}
    And header Authorization = 'Bearer ' + accessTokenFeature.response.id_token
    When method POST
    Then status 200
    
    Examples:
    | setGaugeTestData.entities |
