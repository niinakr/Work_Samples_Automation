*** Settings ***
Documentation     Resource file
Resource          ../Global_Resources/Global_resource.robot
Library           SeleniumLibrary
Library           String
Library           OperatingSystem


*** Keywords ***
Open Outlook With Chrome
    Open Browser      ${URL}    chrome
    Maximize Browser Window

Login In With ACC
    Input Text     ${USERNAME_PATH}     ${OUTLOOKUSERNAME}
    Input Text     ${PASSWORD_PATH}     ${OUTLOOKPASSWORD}
    Click Element  ${SIGNIN_BUTTON_PATH}

Click New Email
    Wait Until Keyword Succeeds  2 min  5 sec   Click Element  ${NEWMAIL}

Check if Namelist is Empty
    [Documentation]     Checking the lenght of namelist and using IF..ELSE condition to send correct message.
        ...
    ${TextFileContentEmails}=    Get File    ${CURDIR}${/}..\\..\\DynamoFiles\\mails.txt
    ${length} =	Get Length	${TextFileContentEmails}
    Run Keyword If    ${length}>1    Add Specific Email Info and Send
                       ...  ELSE     Send Congratulation of Filled Working Hours

Add Specific Email Info and Send
    [Documentation]     Sending a message to teams group and private outlook mail to people who have missing work hours.
        ...
    ${TextFileContentEmails}=    Get File    ${CURDIR}${/}..\\..\\DynamoFiles\\mails.txt
    ${TextFileContentNames}=    Get File     ${CURDIR}${/}..\\..\\DynamoFiles\\namelist_teams.txt
    Wait Until Keyword Succeeds  2 min  5 sec    Press Key   ${TO_PATH}    ${TEAMSCHANNEL}${TextFileContentEmails}
    Input Text  ${SUBJECT_PATH}     Dynamon tuntikirjaukset
    Input Text  ${MESSAGE_PATH}     Hei, Sinulla on viime viikolta kirjauksia alle 36h. Käythän tarkistamassa kirjaukset. Kiitos.${\n} ${\n}${TextFileContentNames}${\n} ${\n}T:Mauri Robotti
    Click Element   ${SEND_BUTTON_PATH}


Send Congratulation of Filled Working Hours
    [Documentation]     Sending congratulations message to teams group.
        ...
    Wait Until Keyword Succeeds  2 min  5 sec   Press Key   ${TO_PATH}    ${TEAMSCHANNEL}
    Input Text  ${SUBJECT_PATH}     Dynamon tuntikirjaukset
    Input Text  ${MESSAGE_PATH}     Hei, Kaikki ovat kirjanneet viime viikon tunnit Dynamoon. Hieno juttu, jatkakaa samaan malliin! ${\n} ${\n}T:Mauri Robotti
    Click Element   ${SEND_BUTTON_PATH}
