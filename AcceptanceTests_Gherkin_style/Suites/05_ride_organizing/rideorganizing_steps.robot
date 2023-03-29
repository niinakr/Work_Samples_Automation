*** Settings ***
Documentation
...                 Steps file implement the actions needed for every step of the Gherkin test.
Resource            rideorganizing_helpers.robot
Resource            ../global_resources/global_resources.robot
Resource            ../04_trip_ordering/tripordering_helpers.robot
Resource            ../04_trip_ordering/tripordering_steps.robot


*** Keywords ***
Organizer Navigates To Ride Management View
        Open Ride Management View

Organizer Confirms An Unconfirmed Ride
        Open The Ride With ID                      ${ORDER ID}
        Click The Status Icon Of Ride
        Approve The Ride

The Ride Is Succesfully Confirmed
        Check Given Notification Message    Tilaus vahvistettu

Customer Is Able To See The Confimation Email Of Her Upcoming Ride
        Open Fake Smtp Server
        Open Email Message              ${CREDIT ROBOT CUSTOMER}    
        Email Contains Valid Details    pickupaddress=${selectedStartAddress}   deliveryaddress=${selectedEndAddress}
        Email Contains Calendar Attachment
        [Teardown]    Close Context

Organizer Navigates To Schedules Management View
        Open Vehicle Schedules View

Organizer Navigates To Partner Groups View
        Open Partner Groups View

Organizer Clicks The Type Of Car
        Open The Car Type Category      ${CAR TYPE}

Adds A New Schedule
        Click A New Schedule

Chooses The Driver And Saves
        Open The Driver Category               ${VALID FULLNAME DRIVER}
        Add Shift Hours For Driver Schedule    16
        Save The Schedule
        Check Given Notification Message       Tallennus onnistui

Schedule Is Created To The Driver
        Created Schedule Is Visible         ${VALID FULLNAME DRIVER}

Organizer Opens The Unhandled Ride
        Open The Ride With ID                      ${ORDER ID}

Selects Driver To Ride And Saves
        Select Driver And Car               ${VALID FULLNAME DRIVER}
        Save The Driver To Ride
        Check Given Notification Message    Kuljettaja määritelty

Ride Status Is Changed To "Assigned"
        Open The Ride With ID                      ${ORDER ID}
        Get Text                            text=Käsitelty

Clicks To Create New Partner Group
        Click A New Partner Group

Enter New Partner Group Details
        Enter Partner Group Name            ${TIMESTAMP}
        Select Two Partner Organizations

Organizer Clicks To Save Partner Group
        Click Save Partner Group

Partner Group Is Shown In Partner Groups List
        Partner Group Is Visible            ${TIMESTAMP}

Organizer Clicks To Delete Partner Group
        Click Delete Partner Group          ${TIMESTAMP}

Partner Group Is Not Shown In Partner Groups List
        Partner Group Is Not Visible        ${TIMESTAMP}

Organizer Chooses Partner Groups
        Click To Open Partner Group Dropdown
        Select Partner Groups On Ride View
        Click To Save Selected Partners
        Click To Close Ride Dialog From X
        Organizer Logs Out

Ring Organizer From Another Company Logs In
        Log In To App
        ...   ${Oy Yritys Ab Organizer Username}
        ...   ${Valid Password}

Ride Is Shown To Selected Partner Groups
        Navigate To Week From The Current Day
        Organizer Opens The Unhandled Ride
        Ride Should Display Service Provider

Ring Organizer From Another Company Should Not See The Order
        Organizer Navigates To Ride Management View
        Selects Day After Week From The Current Day
        Check That Ride Is Not Visible    ${ORDER ID}
        Ring Organizer Logs Out & Organizer Logs In
        Organizer Navigates To Ride Management View
        Selects Day After Week From The Current Day

Ring Organizer Logs Out & Organizer Logs In
        Log Out
        Delete All Cookies
        Log In To App
        ...    username=${Valid Username Organizer}
        ...    password=${Valid Password}

Organizer Logs Out
        Log Out
        Delete All Cookies
