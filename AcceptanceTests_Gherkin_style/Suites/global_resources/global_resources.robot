*** Settings ***
Documentation     Contains resources and keywords that are used in more than one test suite
Library           String
Library           Browser    timeout=15    auto_closing_level=SUITE       retry_assertions_for=30
Library           DateTime
Library           DateTimeTZ
Library           Collections
Library           DebugLibrary
Resource          RobotUsers.resource


*** Variables ***
# ************************** Test data Variables ******************************
${BROWSER}                           firefox
${DELAY}                             0:00:00
${HEADLESS}                          true
${WINDOWWIDTH}                       1440
${WINDOWHEIGHT}                      900
${REC}                               ${EMPTY}
${ACTION}                            yes
${INVALID USERNAME}                  testuser@blabla.notfound
${INVALID PASSWORD}                  Salasana2
${CAR TYPE}                          Coach
${SCHEDULE DELETE NOTIFICATION}      Poistettu
${NETS VISA}                         4925000000000004
${NETS VISA MASKED}                  492500

# ************************** Common Variables ******************************
${ENVIRONMENT}           dev
&{APP_URL}               lab=https://app-ecs-lab.azurewebsites.net/
...                      dev=https://app-fets-dev.azurewebsites.net/
...                      local=https://localhost:5001/
...                      localdocker=https://host.docker.internal:5001/
...                      qa=https://app-ecs-qa.westeurope.cloudapp.azure.com/
...                      production=https://app-pecs-prod.azurewebsites.net/
&{SMTP SERVER URL}       lab=http://ecsmail:TestimAilit2839@maildev-ecs-dev.westeurope.azurecontainer.io:1080/
...                      dev=http://ecsmail:TestimAilit2839@maildev-ecs-dev.westeurope.azurecontainer.io:1080/
...                      local=http://localhost:1080/
...                      localdocker=http://host.docker.internal:1080/
...                      qa=http://ecsmail:TestimAilit2839@maildev-ecs-qa.westeurope.azurecontainer.io:1080/
...                      production=http://ecsmail:TestimAilit2839@maildev-ecs-qa.westeurope.azurecontainer.io:1080/
&{DIALOG_URL}            lab=https://ecs-dialogimock-dev.azurewebsites.net/sms
...                      dev=https://ecs-dialogimock-dev.azurewebsites.net/sms
...                      local=http://localhost:5002/sms
...                      localdocker=http://host.docker.internal:5002/sms
...                      qa=https://ecs-dialogimock-qa.azurewebsites.net/sms
&{PAYMENT_GUID}          lab=a5532411-0f33-4a8a-8bde-6023ebc46f93
...                      dev=a5532411-0f33-4a8a-8bde-6023ebc46f93
...                      local=a5532411-0f33-4a8a-8bde-6023ebc46f93
...                      localdocker=a5532411-0f33-4a8a-8bde-6023ebc46f93
...                      qa=9f1cfb82-0b6f-41a4-a7e5-5f0ae538af39
&{PASSENGERGUID}         lab=dfd44cec-2614-4eb4-8091-958399e2ea0d
...                      dev=dfd44cec-2614-4eb4-8091-958399e2ea0d
...                      local=dfd44cec-2614-4eb4-8091-958399e2ea0d3
...                      localdocker=dfd44cec-2614-4eb4-8091-958399e2ea0d
...                      qa=5e584814-0bf7-4f0c-8bd7-1d78dfa4f644


# ************************** Locators *********************************
${LOGIN_USERNAME_LOCATOR}    //*[@data-test-id = "login-username"]
${LOGIN_PASSWORD_LOCATOR}    //*[@data-test-id = "login-password"]
${LOGIN_SUBMIT_BUTTON}       //*[@data-test-id = "login-button"]
${MENU_BUTTON}               //*[@data-test-id = "menu"]


*** Keywords ***
Get Time
    [Documentation]    This keyword creates timestamp as unique ID to all test suites
    ${TIMESTAMP}       Get Timestamp
    ${TIMESTAMP}       Replace String      ${TIMESTAMP}     :           ${empty}
    ${TIMESTAMP}       Replace String      ${TIMESTAMP}     .           ${empty}
    ${TIMESTAMP}       Replace String      ${TIMESTAMP}     -           ${empty}
    ${TIMESTAMP}       Replace String      ${TIMESTAMP}    ${space}     ${empty}
    Log To Console     Timestamp is ${TIMESTAMP}
    Set Global Variable     ${TIMESTAMP}

Get Date After Week
    [Documentation]    This keyword is needed when creating a trip in 04_trip_ordering suite
    ${TDATE}                            Get Current Date    result_format=%d%m%Y    increment=7 day
    Log To Console                      Day after week is ${TDATE}
    Set Global Variable                 ${TDATE}

Log In To App
    [Arguments]                        ${username}         ${password}
    Wait Until Network Is Idle
    Input Username                     ${username}
    Input Password                     ${password}
    Click                              ${LOGIN_SUBMIT_BUTTON}
    Check That Userinfo Is Received    ${username}

Check That Userinfo Is Received
    [Arguments]                         ${username}
    &{userInfo}                         Wait For Response
    ...                                 matcher=${APP_URL.${ENVIRONMENT}}connect/userinfo
    Should Be Equal As Strings          ${userInfo.body.name}        ${username}
    Should Be Equal As Integers         ${userInfo.status}    200

Log Out
    Get Element                         ${MENU_BUTTON}
    Click                               xpath=.//header//button[2]
    Get Element                         xpath=.//a[@href="/logout"]
    Click                               xpath=.//a[@href="/logout"]
    User Sees Login Page

#Run This Keyword In Case Of Failure
#    Take Screenshot
    #Go To    ${APP_URL.${ENVIRONMENT}}

Reload The Page
    Reload

Click Menubar
    Get Element                         ${MENU_BUTTON}
    Click                               ${MENU_BUTTON}
    Wait Until Network Is Idle          timeout=20

Check If Any Browsers Are Open And Open One If Not
    Count Browsers
    IF    '${numberOfBrowsers}' == '0'
          Open My Browser
    ELSE
        Open New Context
        Log To Console    Open new Context
    END

Open New Context
    New Context                         ignoreHTTPSErrors=true    recordVideo=${REC}
    New Page                            ${APP_URL.${ENVIRONMENT}}

Count Browsers
    @{browser_ids}                      Get Browser Ids
    ${numberOfBrowsers}                 Get Length             ${browser_ids}
    Set Suite Variable                  ${numberOfBrowsers}    ${numberOfBrowsers}
    Log To Console                       numb of browser ${numberOfBrowsers}

Open My Browser
    Create Video Setup
    New Browser                         ${BROWSER}    headless=${HEADLESS}    timeout=40    slowMo=${DELAY}  
    New Context                         ignoreHTTPSErrors=true    bypassCSP=true  recordVideo=${REC}  
    New Page                            ${APP_URL.${ENVIRONMENT}}
    Wait Until Network Is Idle
    Set Browser Timeout                 timeout=30
    Set Viewport Size                   ${WINDOWWIDTH}    ${WINDOWHEIGHT}
    Wait Until Network Is Idle
    Sleep                                2s
    browser.Go To                        ${APP_URL.${ENVIRONMENT}}   
    Sleep                                2s


Create Video Setup
    IF    '${ACTION}' == 'yes'
        Record Video
    ELSE
        Set Global Variable    ${REC}    None
    END

Record Video
    ${size}                             Create Dictionary    width    ${WINDOWWIDTH}    height    ${WINDOWHEIGHT}
    ${record_video}                     Create Dictionary    size     ${size}           dir       ${OUTPUT DIR}/video
    Set Global Variable                 ${REC}               ${record_video}

Open Fake SMTP Server
    Create Video Setup
    Set Browser Timeout                 timeout=40
    New Context                         ignoreHTTPSErrors=true    recordVideo=${REC}
    New Page                            ${SMTP SERVER URL.${ENVIRONMENT}}
    Set Viewport Size                   ${WINDOWWIDTH}    ${WINDOWHEIGHT}

Open Email Message
    [Arguments]                         ${emailaddress_recipient}
    Get Text                            text=${emailaddress_recipient}
    Click                               //*[contains(text(),"${emailaddress_recipient}")]

Email Contains Valid Details
    [Arguments]                         ${pickupaddress}      ${deliveryaddress}
    Wait For Elements State             //iframe    visible
    Click                               //iframe
    Get Element State                   //iframe >>> text=${pickupaddress}      visible
    Get Element State                   //iframe >>> text=${deliveryaddress}    visible

Email Contains Calendar Attachment
    Click                               xpath=//a[@ng-click= "show('attachments')"]
    Get Element State                   text=calendar.ics    visible

User Sees Login Page
    Get Text                            text=Sisäänkirjautuminen

Input Username
    [Arguments]                         ${username}
    Get Element State                   ${LOGIN_USERNAME_LOCATOR}       visible
    Fill Text                           ${LOGIN_USERNAME_LOCATOR}      ${username}

Input Password
    [Arguments]                         ${password}
    Get Element State                   ${LOGIN_PASSWORD_LOCATOR}      visible
    Fill Secret                         ${LOGIN_PASSWORD_LOCATOR}      ${password}

Input New Password
    [Arguments]                         ${input}
    Fill Secret                         id=password            ${input}

Input Password Check
    [Arguments]                         ${passwordCheck}
    Fill Secret                         id=passwordCheck       ${passwordCheck}

Click Login
   Get Element State                    ${LOGIN_SUBMIT_BUTTON}      visible
    Click                               ${LOGIN_SUBMIT_BUTTON}
    &{loginResponse}                    Wait For Response      matcher=${APP_URL.${ENVIRONMENT}}connect/token
    Log                                 ${loginResponse}

Click To Login But Expect Error
    Click                               ${LOGIN_SUBMIT_BUTTON}

Username Is Visible
    [Arguments]                         ${givenUsername}
    Wait For Elements State             ${givenUsername}        visible
    Wait Until Network Is Idle          timeout=15

Navigate To Week From The Current Day
    FOR   ${index}    IN RANGE     7
          Click                         //*[@data-test-id = "daybrowser-next-button"]
          Wait Until Network Is Idle    timeout=15
          Sleep                         1s
    END

Open The Ride
    [Arguments]                           ${pickupaddress} 
    Get Element State                     text=${pickupaddress}    visible
    Click                                 text=${pickupaddress} 

Open The Ride With ID    
    [Arguments]                            ${rideid}
    Wait For Elements State                ${rideid}        visible
    Click                                  ${rideid}

Check That Ride Is Not Visible
    [Arguments]                            ${rideid}
    Get Element State                      ${rideid}        visible    should not be    True


Click The Status Icon Of Ride
    Click                                  css=div[class*="MuiDialogContent"] svg[id="IconStatus_OrderOK"]

Driver Confirms Ride
    Wait For Elements State                css=button[data-test-id="confirmAssignmentButton"]    visible
    Click                                  css=button[data-test-id="confirmAssignmentButton"]

Approve The Ride
    Confirm Dialog Choice

Confirm Dialog Choice
    Wait For Elements State                css=div[class*="MuiDialogActions"]    visible
    Press Keys                             css=div[class*="MuiDialogActions"]    Enter

Open Vehicle Schedules View
    Click Menubar
    Get Text                               text=Ajovuorot
    Click                                  //*[@data-test-id = "vehicleschedules-link"]

Open Partner Groups View
    Click Menubar
    Get Text                               text=Kumppaniringit
    Click                                  //*[@data-test-id = "partners-link"]

Open The Car Type Category
    [Arguments]                            ${cartype}
    Wait For Elements State                id=category        visible
    Click                                  id=category
    Click                                  xpath=.//li[contains(., "${cartype}")]

Select Driver And Car
    [Arguments]                            ${drivername}
    Click                                  //*[@data-test-id = "showDriverSelectionButton"]
    Press Keys                             css=button[data-test-id="selectDriver0"]    Enter
    Wait For Elements State                text=${drivername}                          visible

Delete Driver's Schedule
    Log In To App
    ...    username=${VALID USERNAME ORGANIZER}
    ...    password=${VALID PASSWORD}
    Open Vehicle Schedules View
    Navigate To Week From The Current Day
    Open The Car Type Category             ${CAR TYPE}
    Wait For Elements State                //*[name()='svg']//*[contains(@d,'M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z')]    visible
    Click                                  //*[name()='svg']//*[contains(@d,'M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z')]
    Click                                  //*[@class = "MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary"]
    Check Given Notification Message       ${SCHEDULE DELETE NOTIFICATION}

Valid Company Name Is Shown On The Page
    [Arguments]                    ${company_name}
    Get Text                       text=${company_name}    should be    ${company_name}

Click To Close Ride Dialog From X
    Click                          xpath=//*[@aria-label = "close"]

Scroll Given Element Into View
    [Arguments]                    ${elementID}
    Execute Javascript             document.getElementById("${elementID}").scrollIntoView()

Select Pseudorandom Start Address
    ${startAddressNumber}          Generate Random String                    2     123456789
    Input Start Address            ${startAddressNumber}
    Wait For Elements State        ul[class="MuiAutocomplete-listbox"]       attached
    ${optionToSelect}              Generate Random String                    1     01234
    Wait For Elements State        xpath=//li[@id='google-map-autocompleterouteSteps.0.address-option-${optionToSelect}']/div  attached
    ${address}                     Get Text    xpath=//li[@id='google-map-autocompleterouteSteps.0.address-option-${optionToSelect}']/div
    Input Start Address            ${address}
    Get Inputted Start Address

Get Inputted Start Address
    ${selectedStartAddress}        Get Attribute              id=google-map-autocompleterouteSteps.0.address    value
    Set Global Variable            ${selectedStartAddress}    ${selectedStartAddress}

Select Pseudorandom End Address
    ${endAddressNumber}            Generate Random String                    2     123456789
    Input End Address              ${endAddressNumber}
    Wait For Elements State        ul[class="MuiAutocomplete-listbox"]       attached
    ${optionToSelect}              Generate Random String                    1     01234
    Wait For Elements State        xpath=//li[@id='google-map-autocompleterouteSteps.1.address-option-${optionToSelect}']/div  attached
    ${address}                     Get Text    xpath=//li[@id='google-map-autocompleterouteSteps.1.address-option-${optionToSelect}']/div
    Input End Address              ${address}
    Get Inputted End Address

Get Inputted End Address
    ${selectedEndAddress}          Get Attribute            id=google-map-autocompleterouteSteps.1.address    value
    Set Global Variable            ${selectedEndAddress}    ${selectedEndAddress}

Input Start Address
    [Arguments]                    ${input}
    Fill Text                      id=google-map-autocompleterouteSteps.0.address       ${input}
    Press Keys                     id=google-map-autocompleterouteSteps.0.address       Space

Input End Address
    [Arguments]                    ${input}
    Fill Text                      id=google-map-autocompleterouteSteps.1.address       ${input}
    Press Keys                     id=google-map-autocompleterouteSteps.1.address       Space

Wait Until Input For Additional Destination Is Visible
    [Arguments]                ${index}
    Wait For Elements State    xpath=//input[@id='google-map-autocompleterouteSteps.${index}.address']    visible

Select Random Additional Address
    [Arguments]                ${index}
    ${addressNumber}           Generate Random String    2     123456789
    Fill Text                  xpath=//input[@id='google-map-autocompleterouteSteps.${index}.address']    ${addressNumber}
    Wait For Elements State    ul[class="MuiAutocomplete-listbox"]    visible
    ${optionToSelect}          Generate Random String                    1     01234
    Wait For Elements State    xpath=//li[@id='google-map-autocompleterouteSteps.${index}.address-option-${optionToSelect}']  attached
    ${address}                 Get Text    xpath=//li[@id='google-map-autocompleterouteSteps.${index}.address-option-${optionToSelect}']/div
    Fill Text                  xpath=//input[@id='google-map-autocompleterouteSteps.${index}.address']    ${address}
    Click                      text=Lähtö
    Append To List             ${additionalDestinations}    ${address}

Create Locator ID For Order
    [Arguments]                      ${rideNumber}
    Set Global Variable              ${ORDER ID}        div[data-test-id="${rideNumber}"]
    Log To Console                   \nRide ${rideNumber} \nfrom ${selectedStartAddress} \nto\n${selectedEndAddress}

Check Given Notification Message
    [Arguments]                      ${messageToCheck}
    Get Text                         css=#client-snackbar    should be    ${messageToCheck}

Check Given Message On Any Page
    [Documentation]    Check any other texts that are not displayed on notification box
    [Arguments]        ${messageToCheck}
    Get Text           text=${messageToCheck}

Selects Day After Week From The Current Day
    Navigate To Week From The Current Day

Verify Order Is Created
    &{response}                      Wait For Response    matcher=${APP_URL.${ENVIRONMENT}}api/Orders    timeout=60s
    Should Be Equal As Integers      ${response.status}   201
    Set Suite Variable               ${orderResponse}     &{response}

Take Note Of Ride Number
    Set Suite Variable               ${rideNumber}    ${orderResponse.body.number}
    Log To Console                   \nRide number: ${orderResponse.body.number}
    Create Locator ID For Order      ${rideNumber}

Create Addresses For API Order
    ${startAddressNumber}            Generate Random String                    2     123456789
    ${endAddressNumber}              Generate Random String                    2     123456789
    Set Global Variable              ${selectedStartAddress}    Ratavartijankatu ${startAddressNumber}, Helsinki, Finland
    Set Global Variable              ${selectedEndAddress}      Kaarlenkatu ${endAddressNumber}, Helsinki, Finland

Create Order As A JSON 
    Create Addresses For API Order
    ${jsonOrder}    Catenate
    ...             {"driveType":0, "additionalInformation":"terminal2",
    ...             "showAdditionalInfoForPassenger":false, "numberOfPassengers":"10",
    ...             "passengerUserGuid":"${PASSENGERGUID.${ENVIRONMENT}}",
    ...              "paymentType":1, "paymentCreditCardGuid": "${PAYMENT_GUID.${ENVIRONMENT}}",
    ...             "usePassengerUserGuid":true,"terminalPickup":true, "rides":[{"plannedPickupDate":"${JSONDate}",
    ...             "requestedVehicleClassGuid":"7986660f-cde5-44af-b074-727f9581481e",
    ...             "sendConfirmationEmailToSubscriber":true,
    ...             "routeSteps":[{"stepOrder":1,"address":"${selectedStartAddress}"},
    ...             {"stepOrder":2,"address":"${selectedEndAddress}"}]}]}
    Set Suite Variable    ${jsonOrder}    ${jsonOrder}

Send JSON Order To Orders API
    &{orderResponse}       Http                /api/Orders       POST    ${jsonOrder}  
    Should Be Equal As Integers                ${orderResponse.status}   201
    Set Global Variable    ${orderResponse}    &{orderResponse}

Create Planned Pickup Date With Increment
    [Arguments]           ${incrementInDays}=7 day
    ${date}               Get Current Date    time_zone=utc   increment=${incrementInDays}    result_format=%Y-%m-%d
    Set Suite Variable    ${JSONDate}         ${date} 12:00
    Add Time To Date      ${JSONDate}         2 hours    result_format=%d.%M.%y
    Log To Console        Planned pickup date for JSON order: ${JSONDate}

Create Driver Schedule As A JSON
    ${scheduleEndTime}     Add Time To Date    ${JSONDate}    4 hours    result_format=%Y-%m-%d
    ${jsonSchedule}        Catenate
    ...    {"driverId":"0fb2b7e6-5c45-4f94-16db-08d8094f96b4",
    ...    "vehicleId":"2b427fe7-fe6f-4bec-ab30-b89584fd49a1",
    ...    "licensePlate":"WSO-466",
    ...    "startTime":"${JSONDate}",
    ...    "endTime":"${scheduleEndTime}"}
    Set Suite Variable     ${jsonSchedule}    ${jsonSchedule}

Create Schedule For Robot Driver Via Vehicleschedules API
    &{scheduleResponse}    Http                /api/vehicleschedules    POST    ${jsonSchedule}
    Should Be Equal As Integers                ${scheduleResponse.status}   201
    Set Suite Variable    ${scheduleResponse}  ${scheduleResponse}

Create Order Via Orders API
    Log In To App
    ...    username=${CREDIT ROBOT CUSTOMER}
    ...    password=${VALID PASSWORD}
    Create Planned Pickup Date With Increment    7 day
    Create Order As A JSON
    Send JSON Order To Orders API
    Take Note Of Ride Number
    Get The Id From The Order
    [Teardown]    Run Keywords    Log Out    AND    Delete All Cookies    AND    Go To    ${APP_URL.${ENVIRONMENT}}

Get The Id From The Order
    ${map_id}              Set Variable    ${orderResponse.body.rides[0].id}
    ${map_id}              Replace String         ${map_id}    -    ${EMPTY}
    Set Global Variable    ${MAP_ID}    ${map_id}
    Log To Console    Order ID is ${MAP_ID} 

SMS Is Sent To Passenger
    Open Dialog SMS Page
    Check That SMS Contains Correct Start Address
    Check Map Link And Details
    [Teardown]    Close Context

Open Dialog SMS Page
    New Context                        ignoreHTTPSErrors=true   recordVideo=${REC}
    New Page                           ${DIALOG_URL.${ENVIRONMENT}}
    Set Viewport Size                  ${WINDOWWIDTH}    ${WINDOWHEIGHT}

Check That SMS Contains Correct Start Address
    ${SMSArrivedStatus}    Wait For Elements State    css=pre    visible
    IF    ${SMSArrivedStatus} == False
        Reload
        Check That SMS Contains Correct Start Address
    ELSE
        Get Text    css=pre    contains    ${selectedStartAddress}
    END
    # Would be a good idea to check other details too
    # The whole SMS test should be separated from the drivers suite

Check Map Link And Details
    Go To                  ${APP_URL.${ENVIRONMENT}}ride/${MAP_ID}
    Get Url                should be    ${APP_URL.${ENVIRONMENT}}ride/${MAP_ID}
    Get Text               h4    contains    AUTONNE ON MATKALLA
    Get Text               body    contains    ${selectedStartAddress}
    ${map_src}             Get Attribute    div a img    src
    Should Not Be Empty    ${map_src}

Wait For Notification To Go Away
    Wait For Elements State    css=#client-snackbar    detached

Get Charge To API
    &{orderResponse}       Http                api/Charge/chargeorders?apiSecret=${chargeapisecret}     GET    
    Should Be Equal As Integers                ${orderResponse.status}   200
    Set Global Variable    ${orderResponse}    &{orderResponse}
    Log To Console   Orden response &{orderResponse}

Email Contains Valid Title 
    [Arguments]                         ${title}      
    Wait For Elements State             //iframe    visible
    Click                               //iframe
    Get Element State                   //iframe >>> text= ${title}       visible

Email Contains Valid Service
    [Arguments]                         ${service}      
    Wait For Elements State             //iframe    visible
    Click                               //iframe
    Get Element State                   //iframe >>> text= ${service}       visible