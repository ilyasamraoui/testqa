Feature: Bridge APIs

  Background:
  * url "https://unb-bridge-dev.afs.socgen"
  
  Scenario: The bridge should expose a rest endpoint to retrieve exchange rates for Madagascar
    Given   path "/exchange-rates"
    And     param baseCurrency = "EUR"
    And     header X-EntityId = "MG"
    When    method GET
    Then    status 201
    
