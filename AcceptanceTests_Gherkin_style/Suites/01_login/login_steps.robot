*** Settings ***
Resource    ../global_resources/global_resources.robot


*** Keywords ***
Browser Is Opened To Login Page
    User Sees Login Page

User Logs In With Valid Username And Password
    Input Username           ${VALID USERNAME CUSTOMER}
    Input Password           ${VALID PASSWORD}
    Click Login

User's Company Is Shown On The Page
    Valid Company Name Is Shown On The Page    ${COMPANY NAME CUSTOMER}

User Is Succesfully Logged In
    Check That Userinfo Is Received    ${VALID USERNAME CUSTOMER}

User Logs In With Invalid Username And Password
    Input Username           ${INVALID USERNAME}
    Input Password           ${INVALID PASSWORD}
    Click To Login But Expect Error

User Should See A Login Error Message
    Check Given Message On Any Page    Tarkista sähköposti
