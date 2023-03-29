*** Settings ***
Documentation
...              Gherkin steps here are used in Trip Ordering test suite
Resource  tripordering_helpers.robot
Resource  ../global_resources/global_resources.robot


*** Variables ***
${START TIME OF RIDE}               1200


*** Keywords ***
Customer Navigates To Order Management View
    Open Ordering View

Customer Orders A New Ride With
    [Arguments]           ${passenger}    ${paymentType}    ${nroOfAdditionalDestinations}
    Click To Open Order Form
    Fill Order Details    ${passenger}    ${TDATE}    ${START TIME OF RIDE}    ${paymentType}
    Add Additional Destinations           ${nroOfAdditionalDestinations}
    Add Additional Information     Additional information here
    Submit Order Form
    Choose Email Booking Confirmation
    Confirm Order Is Created
    #Take Note Of Ride Number
    #Get The Id From The Order

Fill Order Details
    [Arguments]
    ...    ${passenger}                  ${pickupdate}
    ...    ${pickuptime}                 ${paymentType}
    Select Passenger On Order Dialog     ${passenger}
    Input Time                           input_date=${pickupdate}     input_time=${pickuptime}
    Input Car Type                       ${CAR TYPE}
    Select Pseudorandom Start Address
    Select Pseudorandom End Address
    Input Number Of Passengers           1
    Input Payment Type                   ${paymentType}

Ordered Trip Is Visible In The List Of Rides
    Go To Next Week View
    Order Should Be Visible             ${selectedStartAddress} 

Customer Changes Number Of Passengers On Existing Ride
    Open The Ride                       ${selectedStartAddress} 
    Input Number Of Passengers           2
    Click Save

Updated Ride Details Are Visible
    Get Text                         text= 2 henk.

Customer Cancels Existing Ride
    Open The Ride                        ${selectedStartAddress} 
    Cancel The Ride

Ride Is Cancelled And Still Visible In Order View
    Order Should Be Visible              ${selectedStartAddress} 


Customer Reveice Email As Receipt
    Get Charge To API