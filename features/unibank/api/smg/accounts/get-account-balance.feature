Feature: Get Account Balance
  Background: 
    Given url "https://hvip-f-cbg.dns21.socgen/aif/"
    And header Content-Type = "text/xml"
    * def accountBalanceTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/smg/accounts/account-balance-data.yaml')
    * def accountBalanceTestData = read(accountBalanceTestDataFile)
    * def generateRequest = 
    """
    function(data) {
      return `
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
          <soapenv:Header/>
          <soapenv:Body>
              <amp:getAccountBalanceActivityRequestFlow>
                  <amp:requestHeader>
                      <amp:requestId>0110101</amp:requestId>
                      <amp:serviceName>getAccountBalanceActivity</amp:serviceName>
                      <amp:timestamp>2019-03-21T14:09:12.808Z</amp:timestamp>
                  </amp:requestHeader>
                  <amp:getAccountBalanceActivityRequest>
                      <amp:accountIdentifier>
                          <amp:branch>${data.branch}</amp:branch>
                          <amp:currency>${data.currency}</amp:currency>
                          <amp:account>${data.account}</amp:account>
                      </amp:accountIdentifier>
                  </amp:getAccountBalanceActivityRequest>
              </amp:getAccountBalanceActivityRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
      `
    }
    """
  Scenario Outline: Get Account Balance OK [<name>]
    Given path "10/<entity>"
    And request generateRequest(<data>)
    When soap action 'getAccountBalanceActivity'
    Then status 200
    
    Examples:
    | accountBalanceTestData.entities |
