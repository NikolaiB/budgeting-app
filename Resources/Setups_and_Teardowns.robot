*** Settings ***
Documentation     *Description*
...
...               This resource file contains keywords for operations with Budget project.

*** Keywords ***
TEST SETUP - Open New Browser Window
    Open Browser    http://127.0.0.1:3000/    chrome
    Maximize Browser Window

TEST TEARDOWN - Close Browser Window
    Close Browser