*** Settings ***
Documentation
...               Keywords in the helper file describe actions via a test library to interact with the application under test.
Resource         ../global_resources/global_resources.robot


*** Keywords ***
Open Ride Management View
    Click Menubar
    Wait For Elements State   	            //*[@data-test-id = "organizer-link"]    visible
    Click                                   //*[@data-test-id = "organizer-link"]

Click A New Schedule
    Click                                   xpath=//*[@class="MuiButtonBase-root MuiButton-root MuiButton-text"]
    Wait For Elements State                 id=driver        visible

Click A New Partner Group
    Wait For Elements State                 id=addPartnerGroupButton
    Click                                   id=addPartnerGroupButton
    Wait For Elements State                 id=groupName     visible

Open The Driver Category
     [Arguments]                            ${drivername}
     Wait For Elements State                id=driver        visible
     Click                                  id=driver
     Click                                  xpath=.//li[contains(., "${drivername}")]

Save The Schedule
    Click                                   css=button[type="submit"]
    #&{response}                             Wait For Response
    #...                                     matcher=${APP_URL.${ENVIRONMENT}}api/vehicleschedules
    #Should Be Equal As Integers             ${response.status}    201

Add Shift Hours For Driver Schedule
    [Arguments]                             ${hours}
    Fill Text                               id=shiftHoursInput    ${hours}

Created Schedule Is Visible
    [Arguments]                             ${drivername}
    Get Text                                text=${drivername}

Save The Driver To Ride
    Click                                   xpath=//*[@data-test-id = "saveDriverToRide"]

Enter Partner Group Name
    [Arguments]                             ${partnergroupname}
    Wait For Elements State                 id=groupName     visible
    Fill Text                               id=groupName     ${partnergroupname}

Select Two Partner Organizations
    Wait For Elements State                 id=partner2      visible
    Click                                   id=partner2
    Click                                   id=partner3

Click Save Partner Group
    Wait For Elements State                 id=savePartnerGroupButton    visible
    Click                                   id=savePartnerGroupButton

Partner Group Is Visible
    [Arguments]                             ${partnerGroupName}
    Get Text                                text=${partnerGroupName}

Click Delete Partner Group
    [Arguments]                             ${partnergroupname}
    Get Text                                text=${partnergroupname}
    Wait For Elements State                 id=deleteGroup${partnergroupname}      visible
    Click                                   id=deleteGroup${partnergroupname}
    Wait For Elements State                 id=deleteVerifyButton                  visible
    Click                                   id=deleteVerifyButton

Partner Group Is Not Visible
    [Arguments]                             ${partnergroupname}
    Wait For Elements State                 text=${partnergroupname}               Hidden

Click To Open Partner Group Dropdown
    Click                                   id=selectPartnersButton

Select Partner Groups On Ride View
    Click                                   css=input[name="group0"]

Click To Save Selected Partners
    Click                                   id=save-partners-button
    Get Text                                text=Tallennus Onnistui

Ride Should Display Service Provider
    Get Text                                text=Palveluntarjoaja: Robottiyritys
