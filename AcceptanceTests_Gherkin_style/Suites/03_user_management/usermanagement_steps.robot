Documentation
...              A steps file implement the actions needed for every step of the Gherkin test.
...              Variables in the steps are a form of test data
...
...
...

*** Settings ***
Resource            usermanagement_helpers.robot
Resource            ../global_resources/global_resources.robot


*** Variables ***
${PHONE NUMBER}     +358441111111
${PASSWORD}         *****


*** Keywords ***
User Management View Is Open
    Open User Management View

Customer Admin Adds New User
    Click To Invite User
    Input Email                             ${TIMESTAMP}@elisa.fi
    Click Send

Registration Link Is Sent To The New Customer
    Email Is Visible In The User List       ${TIMESTAMP}@elisa.fi

New Customer Is Able To Register To The Service
    Open Fake SMTP Server
    Open Email Message                      ${TIMESTAMP}@elisa.fi
    Open Registration Link
    New User Registration From Invite

New User Registration From Invite
    Input Full Name                         Name ${TIMESTAMP}
    Validate Invite Email                   ${TIMESTAMP}@elisa.fi
    Input Phone Number                      ${PHONE NUMBER}
    Input New Password                      ${PASSWORD}
    Input Password Check                    ${PASSWORD}
    Click Consent And Save
    User Sees Login Page

Browser Is Opened To Login Page
    User Sees Log In Page

New Customer Logs In With Valid Username And Password
    Input Username                            ${TIMESTAMP}@elisa.fi
    Input Password                            ${PASSWORD}
    Click Login

User's Company Is Shown On The Page
    Valid Company Name Is Shown On The Page    Name ${TIMESTAMP}

User Requests New Password Using Forgot Password
    Click "Forgot Password"
    Input Forgotten Email Address    ${TIMESTAMP}@elisa.fi
    Click "Send Email" Button

New Password Is Sent To User
    Open Fake SMTP Server
    Open Email Message               ${TIMESTAMP}@elisa.fi
    Open Reset Password Link

User Is Able To Set New Password
    Input New Password                 ${PASSWORD}new
    Input Password Check               ${PASSWORD}new
    Click Send
    Check Given Notification Message   Salasana vaihdettu
    Click                              text=OK

User Is Able To Log In Using New Password
    Log In To App      username=${TIMESTAMP}@elisa.fi
    ...                password=${PASSWORD}new

Customer Navigates To My Profile
    Go To              ${APP_URL.${ENVIRONMENT}}profile/details
    ${url}             Get Url            contains    /profile/details

Customer Adds A New Card
    Click              css=a[href="/profile/cards"]
    Get Url            contains    /profile/cards
    Click              css=button[data-test-id="add-new-card-button"]
    Input Credit Card Details

Credit Card Is Succesfully Added To My Profile
    Check Given Notification Message    Kortti lisätty onnistuneesti
    Check For Added Cards
    Wait For Notification To Go Away

Customer Has Added A Credit Card
    Check For Added Cards

User Removes A Credit Card
    Delete Credit Card

Credit Card Is Removed From User's Profile Succesfully
    Check Given Notification Message    Kortti poistettu
    Check That No Credit Cards Are Displayed
