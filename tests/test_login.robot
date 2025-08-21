*** Settings ***
Documentation     Login Test suite
Library           SeleniumLibrary
Library    Collections
Test Setup        open the browser with the Mortgage payment url 
#Test Teardown     Close Browser
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
   # Verify card titles in the shop page
    Select the card and add to cart    Nokia Edge
    wait for the end

03. Select the form and navigate to child Window
    Fill the login details and select the admin user     ${valid_username}      ${valid_password} 


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
    Sleep    30s

Verify card titles in the shop page
   @{expectedlist}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
   ${elements}=    Get WebElements    css:.card-title
   ${actualList}=    Create List
   FOR    ${element}    IN    @{elements}
       Log    ${element.text}
       Append To List    ${actualList}    ${element.text}
       
   END  
       Lists Should Be Equal    ${expectedlist}    ${actualList}

Select the card and add to cart
    [Arguments]    ${cardName}
    ${elements}=    Get WebElements    css:.card-title
    ${index}=    Set Variable    1
    FOR    ${element}    IN    @{elements}
        # ${cardName} == ${element.text}
        #  Exit For Loop If    '${cardName}' == '${element.text}'
        #  ${index}=  Evaluate    ${index} + 1 
        ${text}=    Get Text    ${element}
        Exit For Loop If    '${cardName}' == '${text}'
        ${index}=    Evaluate    ${index} + 1
       
   END  
   Click Button    xpath://app-card[${index}]//div[1]//div[2]//button[1]
   Sleep    3s

Fill the login details and select the admin user
    [Arguments]    ${username}    ${password}
    Input Text        id:username    ${username}  
    Input Password    id:password     ${password}   
    Click Element    css:input[value='user'] 
    Wait Until Element Is Visible    css:.modal-body 
    Click Button    id:okayBtn
    Click Button    id:okayBtn
    Click Button    id:okayBtn
    Wait Until Element Is Not Visible    css:.modal-body 
    #Select From List By Label    css:select.form-control    Teacher. 
    #Select From List By Value    css:select.form-control    teach
    #above 2 ways are also correct.
    Select From List By Label    xpath://select[@class='form-control']    Teacher