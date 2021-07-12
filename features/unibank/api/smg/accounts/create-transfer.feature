Feature: Create Transfer
  Background:
    Given url "https://hvip-f-cbg.dns21.socgen/aif/"
    And header Content-Type = "text/html"
    * def transferTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/smg/accounts/transfer-data.yaml')
    * def transferTestData = read(transferTestDataFile)
    * def generateRequest = 
    """
    function(request) {
      return request
    }
    """
  Scenario Outline: create transfer OK [<name>]
    Given path "10/<entity>"
    And request generateRequest(`<request>`)
    When soap action 'createTransfer'
    Then status 200
    
    Examples:
    | transferTestData.entities |
