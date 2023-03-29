*** Settings ***
Documentation
...                 Tests for verifying some of ride organizers features.
...                 Note that the order is created on setup by sending JSON directly to orders API.
Resource            ../global_resources/global_resources.robot
Resource            rideorganizing_steps.robot
Suite Setup         Run Keywords    Open My Browser
...                 AND  Set Strict Mode    False
...                 AND  Get Date After Week
...                 AND  Get Time
...                 AND  Create Order Via Orders API
...                 AND  Log In To App
...                 username=${VALID USERNAME ORGANIZER}
...                 password=${VALID PASSWORD}
Suite Teardown      Run Keywords    Close Context
Test Teardown       Run Keyword     Go To    ${APP_URL.${ENVIRONMENT}}
Force Tags          rideorganizing_features   Smoke    Organizer    orderflow


*** Test Cases ***
Organizer Is Able To Confirm A New Ride
    Given Organizer Navigates To Ride Management View
    And Selects Day After Week From The Current Day
    When Organizer Confirms An Unconfirmed Ride
    Then The Ride Is Succesfully Confirmed
    And Customer Is Able To See The Confimation Email Of Her Upcoming Ride

Organizer Is Able To Create Schedule For A Driver
    Given Organizer Navigates To Schedules Management View
    And Selects Day After Week From The Current Day
    When Organizer Clicks The Type Of Car
    And Adds A New Schedule
    And Chooses The Driver And Saves
    Then Schedule Is Created To The Driver

Organizer Is Able To Assign A Driver To A New Ride
    Given Organizer Navigates To Ride Management View
    And Selects Day After Week From The Current Day
    When Organizer Opens The Unhandled Ride
    And Selects Driver To Ride And Saves
    Then Ride Status Is Changed To "Assigned"
