Feature: Content API

  Background:
  * configure readTimeout = 10000

  Scenario Outline: FAQ listing should succeed (via <name>)
   * text graphqlQuery =
      """
      query contentEntries($input: GetContentEntryListRequest){ 
        contentEntries(input: $input){ 
          body, category, 
          creationDate, format, language, modificationDate, 
          notPublished, order, space, status, tags, title, type, urn, version 
        } 
      }
      """
    Given   url "<endpoint>"
    And     header X-EntityId = "BF"
    And     header X-OperationId = "contentEntries"
    And     request { query: '#(graphqlQuery)', variables: {input: {}} }
    When    method POST
    Then    status 200
    Then    print response.data
    Then    match response $.data.contentEntries == '#notnull'

    Examples:
    | endpoint                                                  | name         |
    | https://dvip-cba.dns21.socgen/content/graphql             | direct       |
    | https://dvip-cba.dns21.socgen/sidecar/graphql             | sidecar      |
    | https://dvipgwt-ext.dns21.socgen/graphql/1.0/operations   | gateway      |
    
