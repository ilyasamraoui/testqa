Feature: Reverse Proxies

  Scenario Outline: SMG call should return a successful response [<name>]
    Given   url "https://bridge-dev.afs.socgen/aif/10/<entity>"
    And     header SOAPAction = "getExchangeRateList"
    And     header Content-Type = "text/xml"
    And     request
      """ 
         <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
            <soap:Body>
              <getExchangeRateListRequestFlow xmlns="http://soprabanking.com/amplitude">
                <requestHeader>
                  <requestId>MONITORING</requestId>
                  <serviceName>MONITORING</serviceName>
                  <timestamp>2021-01-01T00:00:00.000Z</timestamp>
                </requestHeader>
                <getExchangeRateListRequest>
                  <targetCurrencyCode>EUR</targetCurrencyCode>
                  <origin>L</origin>
                </getExchangeRateListRequest>
              </getExchangeRateListRequestFlow>
            </soap:Body>
          </soap:Envelope>         
      """  
    When    method POST
    Then    xmlstring xml = response
    Then    match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Examples:
    | entity | name          |
    | bf     | Burkina       |
    | bj     | Bénin         |
    | bs     | Sénégal       |
    | cg     | Congo         |
    | ci     | Côte d'Ivoire |
    | cm     | Cameroun      |
    | gh     | Ghana         |
    | gn     | Guinéee       |
    | mg     | Madagascar    |
    | mr     | Mauritanie    |
    | td     | Tchad         |
      
