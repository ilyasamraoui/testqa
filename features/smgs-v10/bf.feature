Feature: Amplitude V10 SMGs Burkina (SGBF)

  Background:
    * def env = read('../../dataset/env.yml')
    * def data = read('../../dataset/burkina.yml')
    * def validCustomers = data.@{env}.validCustomers
    Given url env.@{env}.aif_v10 + "bf"
    And   header Content-Type = "text/xml"

  Scenario Outline: GetCertificateOfDepositList should succeed "<customerNumber>"
    Given request
    """
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
                              <amp:customerNumber><customerNumber></amp:customerNumber>
                          </amp:customer>
                      </amp:debitCustomer>
                  </amp:getCoDListRequest>
              </amp:getCoDListRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
    """
    When soap action 'getCoDList'
    Then status 200
    Then xmlstring xml = response
    * print xml
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Examples:
      | validCustomers |

  Scenario Outline: GetTermDepositList should succeed "<customerNumber>"
    Given request
    """
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
                              <amp:customerNumber><customerNumber></amp:customerNumber>
                          </amp:customer>
                      </amp:debitCustomer>
                  </amp:getTDListRequest>
              </amp:getTDListRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
    """
    When soap action 'getTDList'
    Then status 200
    Then xmlstring xml = response
    * match xml contains '<fjs1:tD>'
    * print xml
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Examples:
      | validCustomers |

  #**************** LOANS API ****************
  Scenario Outline: GetAmortizableLoanList should succeed "<customerNumber>"
    Given request
    """
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
                            <amp:customerNumber><customerNumber></amp:customerNumber>
                        </amp:customer>
                    </amp:customer>
                </amp:getAmortizableLoanListRequest>
            </amp:getAmortizableLoanListRequestFlow>
        </soapenv:Body>
      </soapenv:Envelope>
    """
    When soap action 'getAmortizableLoanList'
    Then status 200
    Then xmlstring xml = response
    * match xml contains '<fjs1:amortizableLoan>'
    * string loanData = get xml /*[name()='SOAP-ENV:Envelope']/*[name()='SOAP-ENV:Body']/*[name()='fjs1:getAmortizableLoanListResponseFlow']/*[name()='fjs1:getAmortizableLoanListResponse']/*[name()='fjs1:amortizableLoan'][1]
    * xml loanData = loanData.replaceAll("fjs1:", "")
    * print loanData.amortizableLoan
    Examples:
      | validCustomers |
