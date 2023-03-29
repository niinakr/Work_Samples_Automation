Documentation
...               Chrome Version 71.0.3578.98
...               ChromeDriver 2.45
...               robotframework-seleniumlibrary==3.3.1
...
...               This tasks opens dynamo hour report and gets the names and emails of people who have missing work hours from last week (less than 36 hours).


*** Settings ***
Resource  Dynamo_Resource.robot
Suite Teardown  End Task

*** Tasks ***
Login to Dynamo
    [Documentation]     Login-in with AD-account
    Set Log Level   NONE
    Open Dynamo With Chrome
    Login In With AD-account

Add Names to The Files of Missing Hours
    [Documentation]     Open hour report, identify who is missing hours and add names to the files
    Set Log Level   NONE
    Open Employees Work Item - Report
    Identify Who Is Missing Hours
    Check If All Names Are In Report
