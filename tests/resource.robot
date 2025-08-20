*** Settings ***
Documentation     Login Test suite
Library           SeleniumLibrary

*** Variables ***
${results}
${error_message_login}    css:.alert-danger 
${valid_username}        rahulshettyacademy
${valid_password}        learning
${invalid_password}        123456
${Shop_page_load}        css:.nav-link

*** Keywords ***
open the browser with the Mortgage payment url 
    Open Browser        https://rahulshettyacademy.com/loginpagePractise/    chrome    
    Maximize Browser Window

Close Browser session 
    Close Browser