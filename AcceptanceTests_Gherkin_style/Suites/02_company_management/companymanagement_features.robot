*** Settings ***
Resource            ../global_resources/global_resources.robot
Resource            companymanagement_steps.robot
Suite Setup         Run Keywords   Open My Browser  AND
...                 Set Strict Mode    False    AND
...                 Get time    AND
...                 Log In To App
...                 username=${VALID USERNAME ADMIN}
...                 password=${VALID PASSWORD}
Suite Teardown      Run Keywords    Go To    ${APP_URL.${ENVIRONMENT}}    AND
...                 Log Out    AND
...                 Delete All Cookies
Force Tags          companymanagement_feature    smoke    admin    Usermanagement


*** Test Cases ***
Admin is able to create a new organization
    Given Company Management View Is Open
    When Admin Creates A New Organization
    Then Created Organization Is Visible

Admin is able to modify existing organization's properties
    Given Company Management View Is Open
    When Admin Changes Existing Organization's Name
    Then New Name Is Shown In Organization Details

Admin is able to delete an existing organization
    Given Company Management View Is Open
    When Admin Deletes An Existing Organization
    Then Organization Is Successfully Deleted
