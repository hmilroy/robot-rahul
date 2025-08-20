*** Settings ***
Documentation     Login Test suite 2
Library           SeleniumLibrary
Test Setup        open the browser with the Mortgage payment url 
Test Teardown     Close Browser session
Resource        resource.robot

*** Test Cases ***
Validate Unsuccessful Login
    Fill the login form
    wait until the display error message
    Verify error message is correct

*** Keywords ***
Fill the login form
    Sleep    3s
    Input Text        id:username    ${valid_username}
    Input Password    id:password     ${invalid_password}
    Click Button    signInBtn

wait until the display error message
    Wait Until Element Is Visible    ${error_message_login}     3s

Verify error message is correct
    # ${results}=     Get Text    ${error_message_login} 
    # Should Be Equal As Strings    ${results}    Incorrect username/password.
    Element Text Should Be    ${error_message_login}    Incorrect username/password.