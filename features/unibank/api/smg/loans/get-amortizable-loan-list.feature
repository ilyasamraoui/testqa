Feature: Get Amortizable Loan List
  Background: 
    Given url "https://hvip-f-cbg.dns21.socgen/aif/"
    And header Content-Type = "text/xml"
    * def amortizableLoanListTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/smg/loans/amortizable-loan-list-data.yaml')
    * def amortizableLoanListTestData = read(amortizableLoanListTestDataFile)
    * def generateRequest = 
    """
    function(data) {
      return `
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
        <soapenv:Header/>
        <soapenv:Body>
            <amp:getAmortizableLoanListRequestFlow>
                <amp:requestHeader>
                    <amp:requestId>015</amp:requestId>
                    <amp:serviceName>getAmortizableLoanList</amp:serviceName>
                    <amp:timestamp>2018-05-14T07:16:29.908Z</amp:timestamp>
                </amp:requestHeader>
                <amp:getAmortizableLoanListRequest>
                    <amp:customer>
                        <amp:customer>
                            <amp:customerNumber>${data.customerNumber}</amp:customerNumber>
                        </amp:customer>
                    </amp:customer>
                </amp:getAmortizableLoanListRequest>
            </amp:getAmortizableLoanListRequestFlow>
        </soapenv:Body>
      </soapenv:Envelope>
      `
    }
    """
  Scenario Outline: Get Amortizable Loan List OK [<name>]
    Given path "10/<entity>"
    And request generateRequest(<data>)
    When soap action 'getAmortizableLoanList'
    Then status 200
    
    Examples:
    | amortizableLoanListTestData.entities |
