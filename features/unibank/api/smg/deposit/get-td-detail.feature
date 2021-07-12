Feature: Get Term Deposit detail
  Background: 
    Given url "https://hvip-f-cbg.dns21.socgen/aif/"
    And header Content-Type = "text/xml"
    * def tdDetailTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/smg/deposit/td-detail-data.yaml')
    * def tdDetailTestData = read(tdDetailTestDataFile)
    * def generateRequest = 
    """
    function(data) {
      return `
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
          <soapenv:Header/>
          <soapenv:Body>
              <amp:getTDDetailRequestFlow>
                  <amp:requestHeader>
                      <amp:requestId>001</amp:requestId>
                      <amp:serviceName>getTDDetail</amp:serviceName>
                      <amp:timestamp>2018-05-14T07:16:29.908Z</amp:timestamp>
                  </amp:requestHeader>
                  <amp:getTDDetailRequest>
                      <amp:tdIdentifier>
                          <amp:branchCode>${data.branchCode}</amp:branchCode>
                          <amp:tdNumber>${data.tdNumber}</amp:tdNumber>
                      </amp:tdIdentifier>
                  </amp:getTDDetailRequest>
              </amp:getTDDetailRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
      `
    }
    """
  Scenario Outline: Get Term Deposit Detail OK [<name>]
    Given path "10/<entity>"
    And request generateRequest(<data>)
    When soap action 'getTDDetail'
    Then status 200
    
    Examples:
    | tdDetailTestData.entities |
