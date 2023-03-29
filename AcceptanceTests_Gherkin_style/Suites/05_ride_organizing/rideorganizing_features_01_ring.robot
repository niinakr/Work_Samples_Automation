*** Settings ***
Documentation
...                 Tests for partner ("rinki") features and partner groups
Resource            ../global_resources/global_resources.robot
Resource            rideorganizing_steps.robot
Suite Setup         Run Keywords    Open My Browser
...                 AND  Get date after week
...                 AND  Get Time
...                 AND  Create Order via Orders API
...                 AND  Set Strict Mode    False
Suite Teardown      Run Keywords    Log Out    AND    
...                 Delete All Cookies    AND    
...                 Go To    ${APP_URL.${ENVIRONMENT}}
Force Tags          rideorganizing_features    ring


*** Test Cases ***
Organizer is able to share ride to partner groups
    [Tags]      Organizer  Partnergroups
    Given Ring Organizer From Another Company Logs In
    And Ring Organizer From Another Company Should Not See The Order
    When Organizer Opens The Unhandled Ride
    And Organizer Chooses Partner Groups
    Then Ring Organizer From Another Company Logs In
    And Ride Is Shown To Selected Partner Groups
    [Teardown]    Run Keywords  
    ...           Go To    ${APP_URL.${ENVIRONMENT}}    AND
    ...           Ring Organizer Logs Out & Organizer Logs In

Organizer is able to add partner groups
    [Tags]      Partners
    Given Organizer Navigates To Partner Groups View
    And Clicks To Create New Partner Group
    And Enter New Partner Group Details
    When Organizer Clicks To Save Partner Group
    Then Partner Group Is Shown In Partner Groups List

Organizer is able to remove partner groups
    [Tags]      Partners
    Given Organizer Navigates To Partner Groups View
    When Organizer Clicks To Delete Partner Group
    Then Partner Group Is Not Shown In Partner Groups List
