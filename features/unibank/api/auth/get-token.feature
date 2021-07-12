Feature: get access token
  Background: 
    * def testDataPath = "../../../../"
  Scenario Outline: get access token <name>
    When def accessTokenFeature = call read('get-access-token.feature') {accessDataPath: #(testDataPath + "test-data/unibank/api/auth/<entity>-access-token-data.yaml")}
    Then match accessTokenFeature.responseStatus == 200
    Examples:
    | read(testDataPath + 'test-data/unibank/api/auth/entities.yaml') |