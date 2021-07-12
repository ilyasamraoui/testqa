Feature: Get Account List
  Background: 
    Given url "https://hvip-f-cbg.dns21.socgen/aif/"
    And header Content-Type = "text/xml"
    * def accountListTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/smg/accounts/account-list-data.yaml')
    * def accountListTestData = read(accountListTestDataFile)
    * def generateRequest = 
    """
    function(data) {
      return `
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
          <soapenv:Header/>
          <soapenv:Body>
              <amp:getAccountListRequestFlow>
                  <amp:requestHeader>
                      <amp:requestId>002</amp:requestId>
                      <amp:serviceName>getAccountList</amp:serviceName>
                      <amp:timestamp>2018-05-14T07:16:29.908Z</amp:timestamp>
                  </amp:requestHeader>
                  <amp:getAccountListRequest>
                      <amp:account>
                          <amp:customer>
                              <amp:customer>
                                  <amp:customerNumber>${data.customerNumber}</amp:customerNumber>
                              </amp:customer>
                          </amp:customer>
                      </amp:account>
                  </amp:getAccountListRequest>
              </amp:getAccountListRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
      `
    }
    """
  Scenario Outline: Get Account List OK [<name>]
    Given path "10/<entity>"
    And request generateRequest(<data>)
    When soap action 'getAccountList'
    Then status 200
    
    Examples:
    | accountListTestData.entities |
