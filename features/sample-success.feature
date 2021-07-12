Feature: Bridge APIs

  Background:
  * url "https://unb-bridge-dev.afs.socgen"
  
  Scenario: The bridge should expose a rest endpoint to retrieve exchange rates for Burkina (SGBF)
    Given   path "/exchange-rates"
    And     param baseCurrency = "XOF"
    And     header X-EntityId = "BF"
    When    method GET
    Then    status 200
    
  Scenario: The bridge should expose a rest endpoint to retrieve exchange rates for Mada 
    Given   path "/exchange-rates"
    And     param baseCurrency = "XOF"
    And     header X-EntityId = "MG"
    When    method GET
    Then    status 200

  
    
