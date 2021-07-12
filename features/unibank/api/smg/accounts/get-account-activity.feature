Feature: Get Account Activity
  Background:
    Given url "https://hvip-f-cbg.dns21.socgen/aif/"
    And header Content-Type = "text/xml"
    * def accountActivityTestDataFile = fileUtils.downloadFile(urlBase + 'test-data/unibank/api/smg/accounts/account-activity-data.yaml')
    * def accountActivityTestData = read(accountActivityTestDataFile)
    * def generateRequest =
    """
    function(entity, data) {
      if (entity == "bf") {
        return `
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
                            <amp:branch>${data.branch}</amp:branch>
                            <amp:currency>${data.currency}</amp:currency>
                            <amp:account>${data.account}</amp:account>
                        </amp:accountIdentifier>
                        <amp:movementPeriod>
                            <amp:startDate>${data.startDate}</amp:startDate>
                        </amp:movementPeriod>
                    </amp:getAccountActivityRequest>
                </amp:getAccountActivityRequestFlow>
            </soapenv:Body>
        </soapenv:Envelope>
        `
      } else if (entity =="gh") {
        return `
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
                            <amp:branch>${data.branch}</amp:branch>
                            <amp:currency>${data.currency}</amp:currency>
                            <amp:account>${data.account}</amp:account>
                        </amp:accountIdentifier>
                        <amp:movementPeriod>
                            <amp:startDate>${data.startDate}</amp:startDate>
                            <amp:endDate>${data.endDate}</amp:endDate>
                        </amp:movementPeriod>
                    </amp:getAccountActivityRequest>
                </amp:getAccountActivityRequestFlow>
            </soapenv:Body>
        </soapenv:Envelope>
        `
      } else if(entity == "bs" || entity == "ci") {
        return `
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
                            <amp:branch>${data.branch}</amp:branch>
                            <amp:currency>${data.currency}</amp:currency>
                            <amp:account>${data.account}</amp:account>
                        </amp:accountIdentifier>
                        <amp:movementPeriod>
                          <amp:historyMovementsOnly>
                            <amp:startDate>${data.startDate}</amp:startDate>
                            <amp:endDate>${data.endDate}</amp:endDate>
                          </amp:historyMovementsOnly>
                        </amp:movementPeriod>
                    </amp:getAccountActivityRequest>
                </amp:getAccountActivityRequestFlow>
            </soapenv:Body>
        </soapenv:Envelope>
        `
      }
      return `
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
                          <amp:branch>${data.branch}</amp:branch>
                          <amp:currency>${data.currency}</amp:currency>
                          <amp:account>${data.account}</amp:account>
                      </amp:accountIdentifier>
                      <amp:movementPeriod>
                        <amp:bothMovements>
                          <amp:startDate>${data.startDate}</amp:startDate>
                        </amp:bothMovements>
                      </amp:movementPeriod>
                  </amp:getAccountActivityRequest>
              </amp:getAccountActivityRequestFlow>
          </soapenv:Body>
      </soapenv:Envelope>
      `
    }
    """
  Scenario Outline: Get Account Activity OK [<name>]
    Given path "10/<entity>"
    And request generateRequest("<entity>", <data>)
    When soap action 'getAccountActivity'
    Then status 200

    Examples:
    | accountActivityTestData.entities |
