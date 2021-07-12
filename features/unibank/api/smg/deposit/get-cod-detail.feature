Feature: Get Certificate Of Deposit Detail
  Background: 
    Given url "https://hvip-f-cbg.dns21.socgen/aif/"
    And header Content-Type = "text/xml"
    * def codDetailTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/smg/deposit/cod-detail-data.yaml')
    * def codDetailTestData = read(codDetailTestDataFile)
    * def generateRequest = 
    """
    function(data) {
      return `
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
          <soapenv:Header/>
          <soapenv:Body>
              <amp:getCoDDetailRequestFlow>
                  <amp:requestHeader>
                      <amp:requestId>2</amp:requestId>
                      <amp:serviceName>getCodDetail</amp:serviceName>
                      <amp:timestamp>2019-10-16T09:54:30.666Z</amp:timestamp>
                  </amp:requestHeader>
                  <amp:getCoDDetailRequest>
                      <amp:coDDetailIdentifier>
                          <amp:branchCode>${data.branchCode}</amp:branchCode>
                          <amp:coDNumber>${data.coDNumber}</amp:coDNumber>
                          <amp:subscriptionNumber>${data.subscriptionNumber}</amp:subscriptionNumber>
                      </amp:coDDetailIdentifier>
                  </amp:getCoDDetailRequest>
              </amp:getCoDDetailRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
      `
    }
    """
  Scenario Outline: Get Certificate Of Deposit Detail OK [<name>]
    Given path "10/<entity>"
    And request generateRequest(<data>)
    When soap action 'getCoDDetail'
    Then status 200
    
    Examples:
    | codDetailTestData.entities |
