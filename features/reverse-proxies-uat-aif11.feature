Feature: Reverse Proxies AIF v11 UAT

  Scenario Outline: SMG v11 call should return a successful response [<name>]
    Given   url "https://hvip-f-cbg.dns21.socgen/aif/11/<entity>"
    And     header SOAPAction = "getAccountList"
    And     header Content-Type = "text/xml"
    And     request
      """ 
         <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
         <soapenv:Header/> 
         <soapenv:Body> 
            <amp:getAccountListRequestFlow> 
               <amp:requestHeader> 
                  <amp:requestId>Requete</amp:requestId> 
                  <amp:serviceName>getAccountList</amp:serviceName> 
                  <amp:timestamp>2018-05-14T07:16:29.908Z</amp:timestamp> 
                  <!--Optional:--> 
                  <amp:originalName>Name</amp:originalName> 
                  <!--Optional:--> 
                  <amp:originalId>Id</amp:originalId> 
                  <!--Optional:--> 
                  <amp:originalTimestamp>2018-05-14T07:16:29.908Z</amp:originalTimestamp> 
                  <amp:userCode>SMG123456</amp:userCode> 
               </amp:requestHeader> 
               <amp:getAccountListRequest> 
                  <amp:branch> 
                     <!--Optional:--> 
                     <amp:code>00001</amp:code> 
                  </amp:branch> 
                  <!--Optional:--> 
                  <amp:account> 
                     <!--Optional:--> 
                     <amp:accountNumber> 
                        <!--Optional:--> 
                        <amp:internalFormatAccountOurBranch> 
                           <!--Optional:--> 
                           <amp:branch> 
                              <!--Optional:--> 
                              <amp:code>00001</amp:code> 
                           </amp:branch> 
                           <!--Optional:--> 
                           <amp:currency> 
                              <amp:numericCode>929</amp:numericCode> 
                           </amp:currency> 
                           <!--Optional:--> 
                           <amp:account>00000240908</amp:account> 
                           <!--Optional:--> 
                           <amp:suffix> </amp:suffix> 
                        </amp:internalFormatAccountOurBranch> 
                     </amp:accountNumber>      
                     <amp:customer> 
                        <!--Optional:--> 
                        <amp:customer> 
                           <!--Optional:--> 
                           <amp:customerNumber>000238</amp:customerNumber> 
                        </amp:customer>                    
                     </amp:customer>             
                  </amp:account> 
               </amp:getAccountListRequest> 
            </amp:getAccountListRequestFlow> 
         </soapenv:Body> 
      </soapenv:Envelope>    
      """  
    When    method POST
    Then    xmlstring xml = response
    Then    match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Examples:
    | entity | name          |
    | gn     | Guinéee       |
    | mg     | Madagascar    |
    | mr     | Mauritanie    |
      
      
  Scenario Outline: SMG v11 (HT) call should return a successful response [<name>]
    Given   url "https://hvip-f-cbg.dns21.socgen/aif/11/<entity>t"
    And     header SOAPAction = "getAccountList"
    And     header Content-Type = "text/xml"
    And     request
      """ 
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:amp="http://soprabanking.com/amplitude">
         <soapenv:Header/> 
         <soapenv:Body> 
            <amp:getAccountListRequestFlow> 
               <amp:requestHeader> 
                  <amp:requestId>Requete</amp:requestId> 
                  <amp:serviceName>getAccountList</amp:serviceName> 
                  <amp:timestamp>2018-05-14T07:16:29.908Z</amp:timestamp> 
                  <!--Optional:--> 
                  <amp:originalName>Name</amp:originalName> 
                  <!--Optional:--> 
                  <amp:originalId>Id</amp:originalId> 
                  <!--Optional:--> 
                  <amp:originalTimestamp>2018-05-14T07:16:29.908Z</amp:originalTimestamp> 
                  <amp:userCode>SMG123456</amp:userCode> 
               </amp:requestHeader> 
               <amp:getAccountListRequest> 
                  <amp:branch> 
                     <!--Optional:--> 
                     <amp:code>00001</amp:code> 
                  </amp:branch> 
                  <!--Optional:--> 
                  <amp:account> 
                     <!--Optional:--> 
                     <amp:accountNumber> 
                        <!--Optional:--> 
                        <amp:internalFormatAccountOurBranch> 
                           <!--Optional:--> 
                           <amp:branch> 
                              <!--Optional:--> 
                              <amp:code>00001</amp:code> 
                           </amp:branch> 
                           <!--Optional:--> 
                           <amp:currency> 
                              <amp:numericCode>929</amp:numericCode> 
                           </amp:currency> 
                           <!--Optional:--> 
                           <amp:account>00000240908</amp:account> 
                           <!--Optional:--> 
                           <amp:suffix> </amp:suffix> 
                        </amp:internalFormatAccountOurBranch> 
                     </amp:accountNumber>      
                     <amp:customer> 
                        <!--Optional:--> 
                        <amp:customer> 
                           <!--Optional:--> 
                           <amp:customerNumber>000238</amp:customerNumber> 
                        </amp:customer>                    
                     </amp:customer>             
                  </amp:account> 
               </amp:getAccountListRequest> 
            </amp:getAccountListRequestFlow> 
         </soapenv:Body> 
      </soapenv:Envelope>   
      """  
    When    method POST
    Then    xmlstring xml = response
    Then    match xml contains 'http://schemas.xmlsoap.org/soap/envelope'
    Examples:
    | entity | name          |
    | gn     | Guinéee       |
    | mg     | Madagascar    |
    | mr     | Mauritanie    |
            
