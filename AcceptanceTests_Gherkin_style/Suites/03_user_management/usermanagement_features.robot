*** Settings ***
Resource            ../global_resources/global_resources.robot
Resource            usermanagement_steps.robot
Suite Setup         Run Keywords   Open My Browser
...                 AND            Get time
...                 AND            Set Strict Mode  False
...                 AND            Log In To App
...                 username=${VALID USERNAME CUSTOMER ADMIN}
...                 password=${VALID PASSWORD}
#Suite Teardown      Run Keywords    Go To    ${APP_URL.${ENVIRONMENT}}    AND
#...                 Log Out    AND    
#...                 Delete All Cookies
Force Tags          Smoke   Usermanagement


*** Test Cases ***
Customer Admin Is Able To Add New Customers Via The User Management
    [Tags]     CustomerAdmin    Usermanagement
    Given User Management View Is Open
    When Customer Admin Adds New User
    Then Registration Link Is Sent To The New Customer
    And New Customer Is Able To Register To The Service
#    [Teardown]    Run Keywords    
#    ...           Go To    ${APP_URL.${ENVIRONMENT}}    AND
#    ...           Log Out    AND
#    ...           Delete All Cookies

New Customer Is Able To Access The Service With Valid Credentials
    [Tags]    Customer    Usermanagement
    Given Browser Is Opened To Login Page
    When New Customer Logs In With Valid Username And Password
    Then User's Company Is Shown On The Page
    [Teardown]    Run Keywords
    ...           Go To    ${APP_URL.${ENVIRONMENT}}    AND
    ...           Log Out    AND
    ...           Delete All Cookies

Customer Is Able To Request New Password Using "Forgot Password"
    [Tags]    Customer    Usermanagement
    Given Browser Is Opened To Login Page
    When User Requests New Password Using Forgot Password
    Then New Password Is Sent To User
    And User Is Able To Set New Password
    And User Is Able To Log In Using New Password
    [Teardown]    Run Keywords
    ...           Go To    ${APP_URL.${ENVIRONMENT}}    AND
    ...           Log Out    AND
    ...           Delete All Cookies

