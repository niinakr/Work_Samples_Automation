*** Settings ***
Resource    ridedriver_helpers.robot
Resource    ../global_resources/global_resources.robot
Library     Browser


*** Keywords ***
Driver Navigates To Rides View
        Open Rides View

Acknowledges A Ride
        Driver Confirms Ride
        Confirm New Status
        Check If Response Was OK

Success Notification Is Displayed For The Driver
        Check Given Notification Message  Ajon tiedot tallennettu

Driver Opens Drive With Defined Id
        Open The Ride With ID                     ${ORDER ID}

Starts Moving Into Pickup Address
        Click "Move To Location"
        Check If Response Was OK

Driver Opens Ride With Defined Id
        Open The Ride With ID                     ${ORDER ID}

Starts The Ride
        Click "Start Ride"
        Check If Response Was OK

Ends The Drive
        Click "End Ride"

Driver Is Able To Review And Fill Ride Details
        Set Waiting Time                  0015
        Set Ride Length                   7
        Click "Complete Ride"

Driver Is Able To See Revised Details Of The Ride
        Reload The Page
        Navigate To Week From The Current Day
        Select Submitted Rides
        Open The Ride With ID                   ${ORDER ID}
        Ride Length Is Visible            7

Check If Response Was OK
        &{response}                        Wait For Response
        ...                                matcher=${APP_URL.${ENVIRONMENT}}api/Rides/    timeout=30s
        Should Be Equal As Integers        ${response.status}    200
