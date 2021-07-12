Feature: Amplitude V10 SMGs Mauritanie (SGMR)

  Background:
    Given url "https://hvip-f-cbg.dns21.socgen/aif/10/mr"
    And   header Content-Type = "text/xml"
    * def data = read('../../dataset/mauritanie.yml')

#**************** ACCOUNTS API ****************

  Scenario Outline: GetAccountList should succeed
    Given request
    """
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
                                  <amp:customerNumber><customerNumber></amp:customerNumber>
                              </amp:customer>
                          </amp:customer>
                      </amp:account>
                  </amp:getAccountListRequest>
              </amp:getAccountListRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
    """
    When soap action "getAccountList"
    Then xmlstring xml = response
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Then match xml contains '<currency>'
    Then match xml contains '<accountNumber1>'
    Examples:
      | data.validData |

  Scenario Outline: GetAccountActivity should succeed
    Given request
    """
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
        <soapenv:Header/>
        <soapenv:Body>
            <amp:getAccountActivityRequestFlow>
                <amp:requestHeader>
                    <amp:requestId>004</amp:requestId>
                    <amp:serviceName>getAccountActivity</amp:serviceName>
                    <amp:timestamp>2018-05-14T07:16:29.908Z</amp:timestamp>
                </amp:requestHeader>
                <amp:getAccountActivityRequest>
                    <amp:accountIdentifier>
                        <amp:branch><branch></amp:branch>
                        <amp:currency><currency></amp:currency>
                        <amp:account><account></amp:account>
                    </amp:accountIdentifier>
                    <amp:movementPeriod>
                      <amp:bothMovements>
                        <amp:startDate><startDate></amp:startDate>
                      </amp:bothMovements>
                    </amp:movementPeriod>
                </amp:getAccountActivityRequest>
            </amp:getAccountActivityRequestFlow>
        </soapenv:Body>
    </soapenv:Envelope>
    """
    When soap action 'getAccountActivity'
    Then status 200
    Then xmlstring xml = response
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Then match xml contains '<currency>'
    Examples:
      | data.validData |

  Scenario Outline: GetAccountBalance should succeed
    Given request
    """
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
                          <amp:branch><branch></amp:branch>
                          <amp:currency><currency></amp:currency>
                          <amp:account><account></amp:account>
                      </amp:accountIdentifier>
                  </amp:getAccountBalanceActivityRequest>
              </amp:getAccountBalanceActivityRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
    """
    When soap action 'getAccountBalanceActivity'
    Then status 200
    Then xmlstring xml = response
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Then match xml contains '<currency>'
    Examples:
      | data.validData |

  Scenario Outline: GetAccountDetail should succeed
    Given request
    """
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
                          <amp:branch><branch></amp:branch>
                          <amp:currency><currency></amp:currency>
                          <amp:account><account></amp:account>
                      </amp:accountIdentifier>
                  </amp:getAccountDetailRequest>
              </amp:getAccountDetailRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
    """
    When soap action 'getAccountDetail'
    Then status 200
    Then xmlstring xml = response
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Then match xml contains '<currency>'
    Examples:
      | data.validData |

  #**************** DEPOSIT API ****************

  Scenario Outline: GetCertificateOfDepositDetail should succeed
    Given request
    """
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
                          <amp:branchCode><branchCode></amp:branchCode>
                          <amp:coDNumber><coDNumber></amp:coDNumber>
                          <amp:subscriptionNumber><subscriptionNumber></amp:subscriptionNumber>
                      </amp:coDDetailIdentifier>
                  </amp:getCoDDetailRequest>
              </amp:getCoDDetailRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
    """
    When soap action 'getCoDDetail'
    Then status 200
    Then xmlstring xml = response
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Examples:
      | data.validData |

  Scenario Outline: GetCertificateOfDepositList should succeed
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
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Examples:
      | data.validData |

  Scenario Outline: GetTermDepositDetail should succeed
    Given request
    """
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
                          <amp:branchCode><branchCode></amp:branchCode>
                          <amp:tdNumber><tdNumber></amp:tdNumber>
                      </amp:tdIdentifier>
                  </amp:getTDDetailRequest>
              </amp:getTDDetailRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
    """
    When soap action 'getTDDetail'
    Then status 200
    Then xmlstring xml = response
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Examples:
      | data.validData |

  Scenario Outline: GetTermDepositList should succeed
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
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Examples:
      | data.validData |

  #**************** LOANS API ****************

  Scenario Outline: GetAmortizableLoanDetail should succeed
    Given request
    """
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
                          <amp:branchCode><branchCode></amp:branchCode>
                          <amp:fileNumber><fileNumber></amp:fileNumber>
                          <amp:orderNumber><orderNumber></amp:orderNumber>
                          <amp:amendmentNumber><amendmentNumber></amp:amendmentNumber>
                      </amp:amortizableLoanIdentifier>
                  </amp:getAmortizableLoanDetailRequest>
              </amp:getAmortizableLoanDetailRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
    """
    When soap action 'getAmortizableLoanDetail'
    Then status 200
    Then xmlstring xml = response
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Examples:
      | data.validData |

  Scenario Outline: GetAmortizableLoanList should succeed
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
    Then match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Then match xml contains '<currency>'
    Examples:
      | data.validData |
