Feature: login test
  Background: 
    * def testDataPath = "../../../../"
    * configure connectTimeout = 120000
    * configure readTimeout = 120000
    * configure retry = {count:40, interval:3000}
  Scenario Outline: login test OK [<name>]
    * json selectors = <selectors>
    * json data = <data>
    Given driver "https://connect-hf.societegenerale.<entity>/login"
    And waitFor(selectors.accountAccessBtn)
    And click(selectors.accountAccessBtn)
    And waitFor(selectors.usernameInput)
    And input(selectors.usernameInput, data.username)
    And value(selectors.passwordInput, data.password)
    When click(selectors.loginBtn)
    Then waitFor(selectors.title)
    And match text(selectors.title) contains data.title
    Examples:
    | read(testDataPath + 'test-data/unibank/ui/login/test-data-ok/login-data.yaml') |

  Scenario Outline: login test KO [<name>]
    * json selectors = <selectors>
    * json data = <data>
    Given driver "https://connect-hf.societegenerale.<entity>/login"
    And waitFor(selectors.accountAccessBtn)
    And click(selectors.accountAccessBtn)
    And waitFor(selectors.usernameInput)
    And input(selectors.usernameInput, data.username)
    And value(selectors.passwordInput, data.password)
    When click(selectors.loginBtn)
    Then waitFor(selectors.loginErrorMsg)
    And match text(selectors.loginErrorMsg) contains data.loginErrorMsg
    Examples:
    | read(testDataPath + 'test-data/unibank/ui/login/test-data-ko/login-data.yaml') |
