Feature: Get Certificate Of Deposit List
  Background: 
    Given url "https://hvip-f-cbg.dns21.socgen/aif/"
    And header Content-Type = "text/xml"
    * def codListTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/smg/deposit/cod-list-data.yaml')
    * def codListTestData = read(codListTestDataFile)
    * def generateRequest = 
    """
    function(data) {
      return `
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
          <soapenv:Header/>
          <soapenv:Body>
              <amp:getCoDListRequestFlow>
                  <amp:requestHeader>
                      <amp:requestId>1</amp:requestId>
                      <amp:serviceName>getCoDList</amp:serviceName>
                      <amp:timestamp>2019-10-16T09:54:30.666Z</amp:timestamp>
                  </amp:requestHeader>
                  <amp:getCoDListRequest>
                      <!--Optional:-->
                      <amp:debitCustomer>
                          <!--Optional:-->
                          <amp:customer>
                              <!--Optional:-->
                              <amp:customerNumber>${data.customerNumber}</amp:customerNumber>
                          </amp:customer>
                      </amp:debitCustomer>
                  </amp:getCoDListRequest>
              </amp:getCoDListRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
      `
    }
    """
  Scenario Outline: Get Certificate Of Deposit List OK [<name>]
    Given path "10/<entity>"
    And request generateRequest(<data>)
    When soap action 'getCoDList'
    Then status 200
    
    Examples:
    | codListTestData.entities |
