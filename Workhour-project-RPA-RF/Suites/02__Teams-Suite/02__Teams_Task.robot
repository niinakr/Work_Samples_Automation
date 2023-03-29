Documentation     Dynamo HEADLESS script
...               Chrome Version 71.0.3578.98
...               ChromeDriver 2.45
...               robotframework-seleniumlibrary==3.3.1
...
...               This tasks sends teams message to the general channel and private outlook message as a reminder to peoples who have missing work hours from last week.

*** Settings ***
Documentation    Suite description
Resource  Teams_Resource.robot
Suite Teardown  End Task

*** Tasks ***
Open Web Outlook
    [Documentation]     Send Email via Outlook to Teams group and private outlook message to people who have missing work hours.
    Open Outlook With Chrome
    Login In With ACC
    Click New Email
    Check if Namelist is Empty