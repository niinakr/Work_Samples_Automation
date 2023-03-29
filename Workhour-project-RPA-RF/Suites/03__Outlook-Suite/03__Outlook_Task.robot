Documentation     Dynamo HEADLESS script
...               Chrome Version 71.0.3578.98
...               ChromeDriver 2.45
...               robotframework-seleniumlibrary==3.3.1
...
...               This tasks sends a private outlook message to Superiors including the names of peoples who have missing work hours from last week.

*** Settings ***
Documentation    Suite description
Resource  Outlook_Resource.robot
Suite Teardown  End Task

*** Tasks ***
Open Web Outlook
    [Documentation]     Send Email via Outlook to superiors including the names of people who have missing work hours
    Open Outlook With Chrome
    Login In With ACC
    Click New Email
    Check if Namelist is Empty