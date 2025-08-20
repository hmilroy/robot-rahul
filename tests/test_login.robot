*** Settings ***
Documentation     Login Test suite
Library           SeleniumLibrary
Library    Collections
Test Setup        open the browser with the Mortgage payment url 
Test Teardown     Close Browser
Resource        resource.robot

*** Test Cases ***
01. Validate Unsuccessful Login
    Fill the login form     ${valid_username}      ${invalid_password} 
    Wait Until Element is located in the page    ${error_message_login} 
    Verify error message is correct
    wait for the end

02. Validate successful Login
    Fill the login form    ${valid_username}      ${valid_password} 
    Wait Until Element is located in the page    ${Shop_page_load}
    Verify card titles in the shop page


*** Keywords ***
Fill the login form
    Sleep    3s
    [Arguments]    ${username}    ${password}
    Input Text        id:username    ${username}  
    Input Password    id:password     ${password}   
    Click Button    signInBtn

Wait Until Element is located in the page 
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}    3s

Verify error message is correct
    Element Text Should Be    ${error_message_login}    Incorrect username/password.

wait for the end
    Sleep    3s

Verify card titles in the shop page
   @{expectedlist}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
   ${elements}=    Get WebElements    css:.card-title
   ${actualList}=    Create List
   FOR    ${element}    IN    @{elements}
       Log    ${element.text}
       Append To List    ${actualList}    ${element.text}
       
   END  
       Lists Should Be Equal    ${expectedlist}    ${actualList}