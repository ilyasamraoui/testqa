Feature: get access token
  Background:
    * url "https://hvipapi-f-mgr.dns21.socgen"
    * def accessDataFile = fileUtils.downloadFile(accessDataUrl)
    * yaml data = read(accessDataFile)
    * def basicAuth =
    """
    function(credentials) {
      var temp = credentials.username + ':' + credentials.password;
      var Base64 = Java.type('java.util.Base64');
      var encoded = Base64.getEncoder().encodeToString(temp.toString().getBytes());
      return 'Basic ' + encoded;
    }
    """
  Scenario: get access token OK 
    Given path '/token'
    And header Content-Type = "application/x-www-form-urlencoded"
    And form fields data.formFields
    And header Authorization = basicAuth(data.credentials)
    When method POST
    Then status 200
    And match response contains data.expected
