*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Input and search item
    [Arguments]   ${input_field_locator}  ${item_name}  ${btn_locator}   ${timeout}=None
    Input Text  ${input_field_locator}  ${item_name}
    Wait Until Page Contains Element    ${btn_locator}  timeout=${timeout}
    Click Element   ${btn_locator}

Navigate to Homepage
    [Arguments]   ${url}   ${browser}   ${title_page}
    Open Browser   about:blank   ${browser}
    Go To  ${url}
    Run Keyword And Continue On Failure  Title Should Be    ${title_page}

Exit and Close Browser
    Close browser

