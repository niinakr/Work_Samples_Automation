*** Settings ***
Documentation
...               A feature file contains the testcases of a feature and optional tags to categorize the tests.
...               Test cases are written in domain-specific language using the Gherkin format (Given/When/Then)
...
Resource            ../global_resources/global_resources.robot
Resource            tripordering_steps.robot
Suite Setup         Run Keywords    Open My Browser
...                 AND    Get date after week
...                 AND    Get time
...                 AND    Set Strict Mode    False
...                 AND    Log In To App
...                 username=${VALID USERNAME CUSTOMER}
...                 password=${VALID PASSWORD}
Force Tags          tripordering_features    smoke    customer


*** Test Cases ***
Customer is able to order a new ride
    [Tags]      OrderNewRide
    Given Customer Navigates To Order Management View
    When Customer Orders A New Ride With    RobotCustomer    Invoice    0
    Then Ordered Trip Is Visible In The List Of Rides

Customer is able to modify her own ride
    Given Customer Navigates To Order Management View
    When Customer Changes Number Of Passengers On Existing Ride
    Then Updated Ride Details Are Visible

Customer is able to cancel her own ride
    Given Customer Navigates To Order Management View
    When Customer Cancels Existing Ride
    Then Ride Is Cancelled And Still Visible In Order View

Customer is able to make order with multiple destinations
    [Tags]      MultipleDest
    Given Customer Navigates To Order Management View
    When Customer Orders A New Ride With    RobotCustomer    Invoice    3
    Then Ordered Trip Is Visible In The List Of Rides
    [Teardown]  Run Keywords    Go To    ${APP_URL.${ENVIRONMENT}}
    ...         AND    Log Out
    ...         AND    Delete All Cookies    

Customer is able to make order with credit card
    [Tags]      CreditCard
    [Setup]     Log In To App
    ...         username=${CREDIT ROBOT CUSTOMER}
    ...         password=${VALID PASSWORD}
    Given Customer Navigates To Order Management View
    When Customer Orders A New Ride With    Credit Robot    Credit Card    0
    Then Ordered Trip Is Visible In The List Of Rides
 
