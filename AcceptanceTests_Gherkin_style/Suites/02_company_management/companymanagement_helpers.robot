*** Settings ***
Resource         ../global_resources/global_resources.robot


*** Keywords ***
Open Company Management View
    Click Menubar
    Get Element State                   //*[@data-test-id = "organizations-link"]
    Click                               //*[@data-test-id = "organizations-link"]

Click "New Company"
    Get Element State                   //*[@data-test-id = "org-add-new-button"]
    Click                               //*[@data-test-id = "org-add-new-button"]

Input Company Details
    [Arguments]                         ${input}
    Get Element                         id=orgName
    Type Text                           id=orgName      ${input}
    Click                               xpath=.//span[contains(., 'Palveluntarjoaja')]

Click Submit
    Get Element                         xpath=//*[@data-test-id = "save-button"]
    Click                               xpath=//*[@data-test-id = "save-button"]

Organization Is Visible
    [Arguments]                         ${orgName}
    Get Text                            text=Tallennus onnistui
    Click                               xpath=//*[@placeholder = "search"]
    Fill Text                           xpath=//*[@placeholder = "search"]    ${orgName}
    Get Text                            text=${orgName}

Click Edit Row
    Get Element                         xpath=//*[@data-test-id = "edit-row-button"]
    Click                               xpath=//*[@data-test-id = "edit-row-button"]

Change Company Name
    [Arguments]                         ${input}
    Fill Text                           xpath=//*[@class="MuiInputBase-input MuiInput-input"]   ${input}
    Click                               xpath=//*[@class="MuiButtonBase-root MuiIconButton-root MuiIconButton-colorInherit"]

Click To Delete The Last Row
    Click                               xpath=//*[@data-test-id = "delete-row-button"]
    Click                               xpath=//*[@class="MuiButtonBase-root MuiIconButton-root MuiIconButton-colorInherit"]

