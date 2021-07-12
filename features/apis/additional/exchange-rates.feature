Feature: Additional API

  Scenario Outline: ExchangeRates should succeed (via <name>)
    * text graphqlQuery =
      """
      query exchangeRates($input: GetExchangeRateListRequest){ 
        exchangeRates(input: $input){ 
          baseCurrency, date, rates, symbols 
        } 
      }
      """
    Given   url "<endpoint>"
    And     header X-EntityId = "BF"
    And     header X-OperationId = "exchangeRates"
    And     request { query: '#(graphqlQuery)', variables: {input: {}} }
    When    method POST
    Then    status 200
    Then    print response.data
    Then    match response $.data.exchangeRates == { baseCurrency: '#notnull', date: '#notnull', rates: '#notnull', symbols: '#notnull' }
   Examples:
    | endpoint                                                  | name         |
    | https://dvip-cba.dns21.socgen/additional/graphql          | direct       |
    | https://dvip-cba.dns21.socgen/sidecar/graphql             | sidecar      |
    | https://dvipgwt-ext.dns21.socgen/graphql/1.0/operations   | gateway      |
