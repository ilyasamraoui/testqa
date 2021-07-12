Feature: Get Amortizable Loan Detail
  Background: 
    Given url "https://hvip-f-cbg.dns21.socgen/aif/"
    And header Content-Type = "text/xml"
    * def amortizableLoanDetailTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/smg/loans/amortizable-loan-detail-data.yaml')
    * def amortizableLoanDetailTestData = read(amortizableLoanDetailTestDataFile)
    * def generateRequest = 
    """
    function(data) {
      return `
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
          <soapenv:Header/>
          <soapenv:Body>
              <amp:getAmortizableLoanDetailRequestFlow>
                  <amp:requestHeader>
                      <amp:requestId>014</amp:requestId>
                      <amp:serviceName>getAmortizableLoanDetail</amp:serviceName>
                      <amp:timestamp>2018-05-14T07:16:29.908Z</amp:timestamp>
                  </amp:requestHeader>
                  <amp:getAmortizableLoanDetailRequest>
                      <amp:amortizableLoanIdentifier>
                          <amp:branchCode>${data.branchCode}</amp:branchCode>
                          <amp:fileNumber>${data.fileNumber}</amp:fileNumber>
                          <amp:orderNumber>${data.orderNumber}</amp:orderNumber>
                          <amp:amendmentNumber>${data.amendmentNumber}</amp:amendmentNumber>
                      </amp:amortizableLoanIdentifier>
                  </amp:getAmortizableLoanDetailRequest>
              </amp:getAmortizableLoanDetailRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
      `
    }
    """
  Scenario Outline: Get Amortizable Loan Detail OK [<name>]
    Given path "10/<entity>"
    And request generateRequest(<data>)
    When soap action 'getAmortizableLoanDetail'
    Then status 200
    
    Examples:
    | amortizableLoanDetailTestData.entities |
