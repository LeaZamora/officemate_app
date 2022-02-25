*** Settings ***
Library  RequestsLibrary
Library  Collections

Test Setup  Create Session Test

*** Variables ***
${base_url}     https://www.officemate.co.th/en

*** Test Cases ***
Do a Get Request of homepage and validate the response code is OK
    [Tags]   API
    Create Session  mysession  https://officemate.co.th/en
    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json    charset=utf-8
	${response}=    Get On Session    mysession  /  headers=${headers}
    Status Should Be  200  ${response}

Do a POST Request Search and validate the response code is OK when search has query
    [Tags]   API
    [Documentation]   Send query to api https://officemate.co.th/en/search?mobile.
    ...               It only accepts https://officemate.co.th/en/search/mobile
	${response}=    Create POST REQUEST   mysession    /search  params=mobile
    Should Contain   '${response.status_code}'   '200'

Do a Post Request Search with % and validate the response code should not be 404.
    [Tags]   API
    [Documentation]   Send query to api https://officemate.co.th/en/search?mobile.
    ...               It only accepts https://officemate.co.th/en/search/mobile
    ${response} =    Create POST REQUEST  mysession  /search  %
    Should Not Contain   '${response.status_code}'   '404'   #Check Status as 200

*** Keywords ***
Create Session Test
    Create Session  mysession  https://officemate.co.th/en

Create POST REQUEST
    [Arguments]   ${session}  ${endpoint}   ${params}=${none}
    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json    charset=utf-8
	${response}=   Post Request    ${session}    ${endpoint}  params=${params}
	[Return]   ${response}