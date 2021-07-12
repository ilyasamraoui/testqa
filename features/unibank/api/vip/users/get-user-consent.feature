Feature: get user consent
  Background: 
    Given url 'https://hvip-f-cba.dns21.socgen/sidecar/graphql'
    * def testDataPath = "../../../../../"
    * def accessDataPath = testDataPath + "test-data/unibank/api/auth/"
    * def getUserConsentData = read(testDataPath + 'test-data/unibank/api/vip/accounts/account-list-data.yaml')
    * def generateRequest = 
    """
    function() {
      return `
      mutation{
        registerUserDevice(input:{deviceId:"127" deviceName:"iphoneeeee"
          deviceType:MOBILE_IOS token:"518853",
          pushRegistrationId: "35b145fb-d56a-4196-9594-3dc8310c7897"}){
          deviceId
          name
          type
          urn
          userId
        }
      }
      `
    }
    """
  Scenario Outline: get user consent OK [<name>]
    Given request generateRequest()
    * def accessTokenFeature = call read('../../auth/get-access-token.feature') {accessDataPath: #(accessDataPath + "<entity>-access-token-data.yaml")}
    And header Authorization = 'Bearer ' + accessTokenFeature.response.id_token
    When method POST
    Then status 200
    
    Examples:
    | getUserConsentData.entities |