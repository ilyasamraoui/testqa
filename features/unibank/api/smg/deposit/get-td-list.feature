Feature: Get Term Deposit List
  Background: 
    Given url "https://hvip-f-cbg.dns21.socgen/aif/"
    And header Content-Type = "text/xml"
    * def tdListTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/smg/deposit/td-list-data.yaml')
    * def tdListTestData = read(tdListTestDataFile)
    * def generateRequest = 
    """
    function(data) {
      return `
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
          <soapenv:Header/>
          <soapenv:Body>
              <amp:getTDListRequestFlow>
                  <amp:requestHeader>
                      <amp:requestId>00021221</amp:requestId>
                      <amp:serviceName>serviceName</amp:serviceName>
                      <amp:timestamp>2020-01-13T03:16:21</amp:timestamp>
                  </amp:requestHeader>
                  <amp:getTDListRequest>
                      <amp:debitCustomer>
                          <amp:customer>
                              <amp:customerNumber>${data.customerNumber}</amp:customerNumber>
                          </amp:customer>
                      </amp:debitCustomer>
                  </amp:getTDListRequest>
              </amp:getTDListRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
      `
    }
    """
  Scenario Outline: Get Term Deposit List OK [<name>]
    Given path "10/<entity>"
    And request generateRequest(<data>)
    When soap action 'getTDList'
    Then status 200
    
    Examples:
    | tdListTestData.entities |
