*** Settings ***
Documentation
...              Note: driver suite is dependant on the order created in the previous ride organizing suite
...              Use orderflow tag to run E2E test suite for creating an order
Resource         ../global_resources/global_resources.robot
Resource         ridedriver_steps.robot
Resource         ../05_ride_organizing/rideorganizing_steps.robot
Suite Setup      Run Keywords     Open My Browser
...              AND  Set Strict Mode    False
...              AND  Log In To App
...              username=${VALID USERNAME DRIVER}
...              password=${VALID PASSWORD}
Suite Teardown   Run Keywords    Log Out    AND    
...              Delete All Cookies    AND    
...              Go To    ${APP_URL.${ENVIRONMENT}}    AND
...              Delete Driver's Schedule
Test Teardown    Run Keyword      Go To    ${APP_URL.${ENVIRONMENT}}
Force Tags       ridedriver_features  OrderFlow    Smoke    Driver


*** Test Cases ***
Driver is able to check a new ride
    Given Driver Navigates To Rides View
    And Selects Day After Week From The Current Day
    When Driver Opens Drive With Defined Id
    And Acknowledges A Ride
    Then Success Notification Is Displayed For The Driver

Driver is able to start the drive
    Given Driver Navigates To Rides View
    And Selects Day After Week From The Current Day
    When Driver Opens Drive With Defined Id
    And Starts Moving Into Pickup Address
    Then Success Notification Is Displayed For The Driver
    And SMS Is Sent To Passenger

Driver is able to start the ride
    Given Driver Navigates To Rides View
    And Selects Day After Week From The Current Day
    When Driver Opens Drive With Defined Id
    And Starts The Ride
    Then Success Notification Is Displayed For The Driver

Driver is able to end the ride
    Given Driver Navigates To Rides View
    And Selects Day After Week From The Current Day
    When Driver Opens Drive With Defined Id
    And Ends The Drive
    Then Driver Is Able To Review And Fill Ride Details
    And Success Notification Is Displayed For The Driver
    And Driver Is Able To See Revised Details Of The Ride

