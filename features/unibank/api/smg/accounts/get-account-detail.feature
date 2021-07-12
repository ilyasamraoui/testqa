Feature: Get Account Detail
  Background: 
    Given url "https://hvip-f-cbg.dns21.socgen/aif/"
    And header Content-Type = "text/xml"
    * def accountDetailTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/smg/accounts/account-detail-data.yaml')
    * def accountDetailTestData = read(accountDetailTestDataFile)
    * def generateRequest = 
    """
    function(data) {
      return `
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
          <soapenv:Header/>
          <soapenv:Body>
              <amp:getAccountDetailRequestFlow>
                  <amp:requestHeader>
                      <amp:requestId>1</amp:requestId>
                      <amp:serviceName>serviceName</amp:serviceName>
                      <amp:timestamp>2019-10-16T08:32:12.493Z</amp:timestamp>
                  </amp:requestHeader>
                  <amp:getAccountDetailRequest>
                      <amp:accountIdentifier>
                          <amp:branch>${data.branch}</amp:branch>
                          <amp:currency>${data.currency}</amp:currency>
                          <amp:account>${data.account}</amp:account>
                      </amp:accountIdentifier>
                  </amp:getAccountDetailRequest>
              </amp:getAccountDetailRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
      `
    }
    """
  Scenario Outline: Get Account Detail OK [<name>]
    Given path "10/<entity>"
    And request generateRequest(<data>)
    When soap action 'getAccountDetail'
    Then status 200
    
    Examples:
    | accountDetailTestData.entities |
