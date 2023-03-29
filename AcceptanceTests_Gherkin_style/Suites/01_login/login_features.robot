*** Settings ***
Documentation     Tests for verifying valid customer can log in and invalid credentials won't work
Resource          ../global_resources/global_resources.robot
Resource          login_steps.robot
Suite Setup       Run Keywords
...               Open My Browser    
...               AND    Set Strict Mode    False
Force Tags        Smoke    Customer    Usermanagement  Login


*** Test Cases ***
Customer is able to access the service with valid credentials
    Given Browser Is Opened To Login Page
    When User Logs In With Valid Username And Password
    Then User Is Succesfully Logged In
    And User's Company Is Shown On The Page
    [Teardown]    Run Keywords    Go To    ${APP_URL.${ENVIRONMENT}}    AND    Log Out    AND    Delete All Cookies

Customer is not able to login with invalid credentials
    Given Browser Is Opened To Login Page
    When User Logs In With Invalid Username And Password
    Then User Should See A Login Error Message
    [Teardown]    Go To    ${APP_URL.${ENVIRONMENT}}

