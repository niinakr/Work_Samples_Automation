*** Settings ***
Documentation
...               Keywords in the helper file describe actions via a test library to interact with the application under test.
...               Variables in the helpers are typically locators of elements
Resource         ../global_resources/global_resources.robot


*** Keywords ***
Open User Management View
    Click Menubar
    Get Element                             xpath=//*[@data-test-id = "users-link"]
    Click                                   xpath=//*[@data-test-id = "users-link"]
    Reload The Page

Click To Invite User
    [Documentation]    IF ELSE can be removed after EDUS-431 is fixed ;)
    ${buttonStatus}    Get Element State    id=inviteUserButton    visible
    IF    ${buttonStatus} == False
        Reload
        Wait Until Network Is Idle
        Click To Invite User
    ELSE
        Hover                               id=inviteUserButton
        Click                               id=inviteUserButton
    END

Input Email
    [Arguments]                             ${input}
    Wait For Elements State                 id=inviteEmail         enabled
    Fill Text                               id=inviteEmail         ${input}

Click Send
    Wait For Elements State                 id=save                enabled
    Hover                                   id=save
    Click                                   id=save

Email Is Visible In The User List
    [Arguments]                             ${addedEmail}
    Check Given Notification Message        Lähetetty
    Check Given Message On Any Page         ${addedEmail}

Open Registration Link
    Wait For Elements State                 iframe                          visible
    Wait For Elements State                 iframe >>> text=Rekisteröidy    visible
    Wait Until Network Is Idle
    ${invite_url}=  browser.Get Property    iframe >>> text=Rekisteröidy       href
    browser.Go To                            ${invite_url}
    Get Text                                 text=Tervetuloa!

Input Full Name
    [Arguments]                             ${input}
    Fill Text                               id=fullName            ${input}

Validate Invite Email
    [Arguments]                             ${input}
    Get Text                                id=inviteEmail         shouldbe    ${input}

Input Phone Number
    [Arguments]                             ${input}
    Fill Text                               id=phone               ${input}

Click Consent And Save
    Hover                                   id=consent
    Click                                   id=consent
    Click                                   id=save
    Check Given Notification Message        Rekisteröinti onnistui.
    Click                                   xpath=.//span[contains(., 'OK')]

Click "Forgot Password"
    Click                                   css=a[href="/forgot-password"]
    Wait For Elements State                 id=send-email-button    visible

Input Forgotten Email Address
    [Arguments]                             ${emailaddress}
    Fill Text                               id=emailAddress    ${emailaddress}

Click "Send Email" Button
    Click                                   id=send-email-button
    Check Given Notification Message        Sähköposti lähetetty

Open Reset Password Link
    Wait For Elements State                 //iframe    visible
    Click                                   //iframe
    Wait Until Network Is Idle
    Get Text                                iframe >>> text=Aseta salasana
    ${resetpassword_url}=  browser.Get Property    iframe >>> text=Aseta salasana     href
    browser.Go To                           ${resetpassword_url}
    Get Text                                text=Uusi salasana

Input Credit Card Details
    Fill Text                      id=cardNumber      ${NETS VISA}
    Select Options By              id=month           value    01
    Select Options By              id=year            value    30
    Fill Text                      id=securityCode    123
    Click                          input[name="okButton"]
    &{response}                    Wait For Response
    ...                            matcher=https://test.epayment.nets.eu/terminal/TDSMethod/Check
    Should Be Equal As Integers    ${response.status}    200

Check For Added Cards
    Check Response From Cards API
    Get Text                       css=table    contains    ${NETS VISA MASKED}

Check Response From Cards API
    &{response}                    Http    ${APP_URL.${ENVIRONMENT}}api/Cards
    ...                            Get
    Should Contain                 ${response.body[0].maskedPAN}    ${NETS VISA MASKED}

Delete Credit Card
    Click                          css=tr:nth-child(1) td:nth-child(3) button
    Confirm Dialog Choice
    Check Response From Card Delete

Check Response From Card Delete
    &{response}                    Wait For Response
    ...                            matcher=${APP_URL.${ENVIRONMENT}}api/Cards
    Should Be Equal As Integers    ${response.status}    200

Check That No Credit Cards Are Displayed
    ${tableContents}               Get Text                       css=table
    Should Not Contain             ${tableContents}               ${NETS VISA MASKED}
