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
    Wait Until Keyword Succeeds  2 min  5 sec  Click Element  ${NEWMAIL}

Check if Namelist is Empty
    [Documentation]     Checking the lenght of namelist and using IF..ELSE condition to send correct message.
        ...
    ${TextFileContentNamelist}=    Get File    ${CURDIR}${/}..\\..\\DynamoFiles\\namelist_mail.txt
    ${length} =	Get Length	 ${TextFileContentNamelist}
    Run Keyword If    ${length}>1    Add Specific Email Info and Send
                       ...  ELSE     Send Congratulation of Filled Working Hours

Add Specific Email Info and Send
    [Documentation]     Sending a message to Superiors.
        ...
    ${TextFileContentNamelist}=    Get File    ${CURDIR}${/}..\\..\\DynamoFiles\\namelist_mail.txt
    Wait Until Keyword Succeeds  2 min  5 sec   Press Key  ${TO_PATH}      ${SUPERIORS_MAILS}
    Input Text  ${SUBJECT_PATH}     Henkilöillä alle 36h dynamokirjauksia viimeviikolta
    Input Text  ${MESSAGE_PATH}     Hei, Alla olevilla henkilöillä on alle 36h dynamokirjauksia viime viikolta. Heitä on muistutettu asiasta eilen. ${\n} ${\n}${TextFileContentNamelist} ${\n}T:Mauri Robotti
    Click Element   ${SEND_BUTTON_PATH}

Send Congratulation of Filled Working Hours
   [Documentation]     Sending congratulations message to superiors.
        ...
    Wait Until Keyword Succeeds  2 min  5 sec  Press Key   ${TO_PATH}          ${SUPERIORS_MAILS}
    Input Text  ${SUBJECT_PATH}     Dynamon tuntikirjaukset
    Input Text  ${MESSAGE_PATH}     Hei, Kaikki ovat kirjanneet viime viikon tunnit Dynamoon. Hieno juttu! ${\n} ${\n}T:Mauri Robotti
    Click Element   ${SEND_BUTTON_PATH}
