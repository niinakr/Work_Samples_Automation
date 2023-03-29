*** Settings ***
Resource         ../global_resources/global_resources.robot


*** Keywords ***
Open Rides View
    Click Menubar
    Wait For Elements State                  xpath=//*[@data-test-id = "rides-link"]    visible
    Click                                    xpath=//*[@data-test-id = "rides-link"]

Confirm New Status
    Confirm Dialog Choice

Click "Move To Location"
    Click                                    xpath=//*[@data-test-id = "moveToRideButton"]
    Confirm Dialog Choice

Click "Start Ride"
    Click                                    xpath=//*[@data-test-id = "startRideButton"]
    Confirm Dialog Choice

Click "End Ride"
    Click                                    xpath=//*[@data-test-id = "endRideButton"]

Click "Complete Ride"
    Click                                    xpath=//*[@data-test-id = "completeRideButton"]
    Wait Until Network Is Idle               timeout=30    # Takes a while as invoice is generated on this step...

Set Waiting Time
    [Arguments]                              ${waitingtime}
    Wait For Elements State                  div[data-test-id="approvedWaitingMinutes"] input    visible
    Fill Text                                div[data-test-id="approvedWaitingMinutes"] input    ${waitingtime}

Set Ride Length
    [Arguments]                              ${rideLength}
    Fill Text                                div[data-test-id="approvedRideLengthKmInput"] input      ${rideLength}

Select Submitted Rides
    Click                                    xpath=//*[@name = "rideEnded"]

Ride Length Is Visible
    [Arguments]                              ${rideLength}
    Get Text                                 text=${rideLength}

Open The Driver Category
    [Arguments]                              ${drivername}
    Wait For Elements State                  id=driver        visible
    Click                                    id=driver
    Click                                    xpath=.//li[contains(., "${drivername}")]

Save The Schedule
    Click                                    //*[@class = "MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary"]
    Check Given Notification Message         Tallennus onnistui

Created Schedule Is Visible
    [Arguments]                              ${drivername}
    Get Text                                 text=${drivername}

Save The Driver To Ride
    Click                                    //*[@data-test-id = "saveDriverToRide"]
    Check Given Notification Message         Kuljettaja määritelty

Handled Status Is Visible
    Check Given Notification Message         Käsitelty
