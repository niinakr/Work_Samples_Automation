*** Settings ***
Resource    ../global_resources/global_resources.robot
Resource    companymanagement_helpers.robot


*** Keywords ***
Company Management View Is Open
    Open Company Management View

Admin Creates A New Organization
    Click "New Company"
    Input Company Details               ${TIMESTAMP}
    Click Submit

Created Organization Is Visible
    Organization Is Visible             ${TIMESTAMP}

Admin Changes Existing Organization's Name
    Click Edit Row
    Change Company Name                 EDIT${TIMESTAMP}

New Name Is Shown In Organization Details
    Check Given Message On Any Page     EDIT${TIMESTAMP}          

Admin Deletes An Existing Organization
    Click To Delete The Last Row

Organization Is Successfully Deleted
    Check Given Notification Message        Yrityksen poisto onnistui
    &{response}                         Wait For Response
    ...                                 matcher=${APP_URL.${ENVIRONMENT}}api/organizations/
    Should Be Equal As Strings          ${response.status}        200
