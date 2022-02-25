*** Settings ***
Resource   ${EXECDIR}/resources/common.robot
Resource   ${EXECDIR}/data/locators.robot

Test Setup   Navigate to Homepage    ${base_url}    ${browser}   ${home_page_title}
Test Teardown      Close browser

*** Variables ***
${base_url}     https://www.officemate.co.th/en
${home_page_title}      ออฟฟิศเมท (OfficeMate) ที่เดียวครบ ตอบโจทย์ทุกธุรกิจ
${valid_item}     Mobile
${browser}        chrome
${timeout}        5s

*** Test Cases ***
Verify count of products is correctly displayed on the search result page for a particular search item.
    [Tags]   TEST_1
    Input and search item   ${search_bar_xpath}  ${valid_item}  ${search_button_element}   timeout=${timeout}
    Wait Until Page Contains Element   ${product_class}  timeout=${timeout}
    Page Should Contain Element   ${product_class}   limit=45

Verify search bar input valid item name should be successful
    [Tags]   TEST_2
    Input and search item   ${search_bar_xpath}  ${valid_item}  ${search_button_element}   timeout=${timeout}
    Wait Until Page Contains Element   ${product_class}  timeout=${timeout}
    ${element_list}   Get WebElements   ${product_class}
    ${count}  Get Length  ${element_list}
    FOR    ${i}    IN RANGE   ${count}
        ${actual}    Set Variable    ${element_list[${i}].text}
        Run Keyword and Continue On Failure  Should Contain    ${actual.upper()}    ${valid_item.upper()}
    END