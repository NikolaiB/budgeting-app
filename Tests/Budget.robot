*** Settings ***
Documentation     *Suite Description*
...
...               This test suite contains tests that check basic functionality of Budget page.
Library           SeleniumLibrary
Resource         ../Resources/Setups_and_Teardowns.robot
Resource         ../Resources/Budget_page.robot
Test Setup       TEST SETUP - Open New Browser Window
Test Teardown    TEST TEARDOWN - Close Browser Window

*** Test Cases ***
Add Income
    [Documentation]    _*TEST #1*_
    ...
    ...    Adding a new item in the Budget app.
    [Tags]  positive  smoke
    Select From List By Label  categoryId  Income
    Input Text  description  Salary
    Input Text  value  1000
    Click Button  ${BTN_SUBMIT}
    Table Cell Should Contain  ${TABLE_CELL}  8  3  $1,000.00
    Element Should Contain  ${WORKING_BALANCE}  $3,213.93

Update Income
    [Documentation]    _*TEST #2*_
    ...
    ...    Updating excisting item in the Budget app.
    [Tags]  positive  smoke
    Click Element  ${ROW_SIX}
    Input Table  description  Salary
    Input Table  value  6700
    Click Button  ${BTN_SUBMIT}
    Table Cell Should Contain  ${TABLE_CELL}  7  3  $6,700.00
    Element Should Contain  ${WORKING_BALANCE}  $3,213.93

Cancel Income
    [Documentation]    _*TEST #3*_
    ...
    ...    Canceling the item's update in the Budget app.
    [Tags]  positive  smoke
    Click Element  ${ROW_SIX}
    Element Should Be Visible  ${BTN_CANCEL}
    Click Button  ${BTN_CANCEL}
    Element Should Not Be Visible  ${BTN_CANCEL}

Delete Income
    [Documentation]    _*TEST #4*_
    ...
    ...    Deleting the item in the Budget app.
    [Tags]  positive  smoke
    Element Should Contain  ${WORKING_BALANCE}  $2,213.93
    Click Element  ${ROW_FIFTH}
    Click Button  ${BTN_DELETE}
    Element Should Contain  ${WORKING_BALANCE}  $3,313.93

Delete Income
    [Documentation]    _*TEST #5*_
    ...
    ...    This test scenario shows the bug in ${WORKING_BALANCE} field. It should contain the negative number.
    [Tags]  negative  smoke
    Element Should Contain  ${WORKING_BALANCE}  $2,213.93
    Click Element  ${ROW_SIX}
    Click Button  ${BTN_DELETE}
    Element Should Contain  ${WORKING_BALANCE}  $-3,486.07

*** Keywords ***
Input Table
    [Documentation]    This keyword pushes the delete key (ascii: \8) a specified number of times in a specified field.
    [Arguments]    ${locator}   ${value}
    ${element}  Get Value  ${locator}
    ${count}  Get Length  ${element}
    : FOR    ${index}    IN RANGE    ${count}
    \    Press Key    ${locator}  \\8
    Input Text  ${locator}  ${value}