*** Settings ***
Documentation     Resource file
Resource          ../Global_Resources/Global_resource.robot
Library           SeleniumLibrary
Library           String
Library           OperatingSystem
Library           Collections

*** Variables ***
#************************** Common Variables ******************************
${ENVIRONMENT}  prod
&{URL}   dev=https://dynamodev.appelsiini.com/  prod=https://dynamo.appelsiini.com/
&{REPORT_URL}     dev=https://dynamodev.appelsiini.com/nav_to.do?uri=%2Fsys_report_template.do%3Fjvar_report_id%3D95c084f054f36bc4fe87b31cdf7b6985  prod=https://dynamo.appelsiini.com/nav_to.do?uri=%2Fsys_report_template.do%3Fjvar_report_id%3D42dd7720dd3baf40bbde58c7af7ee64f


#************************** Locators *********************************#
${USERNAME_PATH}    xpath=//*[@id="user_name"]
${PASSWORD_PATH}    xpath=//*[@id="user_password"]
${SUBMIT_BUTTON_PATH}   xpath=//*[@id="sysverb_login"]
${USER_PROFILE_PATH}    xpath=//*[@id="user_info_dropdown"]
${HOUR_ELEMENTS_PATH}   //*[@class="pivot_caption"]
${NAME_ELEMENTS_PATH}   //*[@class="pivot_caption pivot_left"]

*** Keywords ***
Open Dynamo With Chrome
    Open Browser      ${URL.${ENVIRONMENT}}    chrome

Login In With AD-account
    Select Frame   xpath=//iframe
    Wait Until Page Contains Element  ${USERNAME_PATH}  120s
    Input Text     ${USERNAME_PATH}     ${DYNAMOUSERNAME}
    Input Text     ${PASSWORD_PATH}     ${DYNAMOPASSWORD}
    Click Element  ${SUBMIT_BUTTON_PATH}
    Wait Until Page Contains Element         ${USER_PROFILE_PATH}   120s

Open Employees Work Item - Report
   Go To    ${REPORT_URL.${ENVIRONMENT}}

Identify Who Is Missing Hours
    [Documentation]     Creating 3 Dynamo output files:
        ...                 1. namelist_mail.txt --> <Firstname Surename> <Work Hours> --> Message content to Superiors
        ...                 2. mails.txt ---> <email address> --> Recipients of Outlook email
        ...                 3. namelist:teams --->  <Firstname Surename> --> Message content to Teams Group
        ...             Looping over a list of name and work hour HTML elements(objects). Getting the text content (attribute) of each element.
        ...             Converting elements to specific type and creating task variables.
        ...             Using conditional execution IF comparision of work hour element is true.
        ...
    Create file    ${CURDIR}${/}..\\..\\DynamoFiles\\namelist_mail.txt
    Create file    ${CURDIR}${/}..\\..\\DynamoFiles\\mails.txt
    Create file    ${CURDIR}${/}..\\..\\DynamoFiles\\namelist_teams.txt
    ${index} =    Set Variable    -1
    Select Frame   xpath=//iframe
    Wait Until Page Contains Element    ${NAME_ELEMENTS_PATH}    120s
    ${hour_elements}=    Get WebElements    ${HOUR_ELEMENTS_PATH}
    ${name_elements}=     Get WebElements   ${NAME_ELEMENTS_PATH}
    :FOR   ${name_element}    IN    @{name_elements}
     \     ${index} =    Evaluate    ${index} + 1
     \     ${hour_element} =     Replace String     ${hour_elements[${index}].text}  ,    .
     \     ${hour_element} =     Convert To Number      ${hour_element}
     \     Set Task Variable      ${name}  ${name_elements[${index}].text}
     \     Set Task Variable     ${hour}  ${hour_element}
     \     Run Keyword If    ${hour_element} <= 35   Split Names

Check If All Names Are In Report
    [Documentation]     Creates a list of all members of the team.
        ...             Looping over a list and checking all elements of the list if it's found from the dynamo report.
        ...             -> The status variable is PASS or FAIL
        ...             Using conditional execution IF  comparison and run keyword 'Split Names' if the name is not found and its status is FAIL
    Select Frame   xpath=//iframe
    @{list} =	Create List     Anders Borgström  Antti Salomäki  Jaakko Heikkilä  Janne Juopperi  Jari Flink  Leena Koskinen  Mika Uurainen  Niina Rantanen  Ossi Karhunen  Pasi Säkkinen  Pasi Seppänen  Pekka Haara  Pekka Huuskonen  Raine Pyssysalo  Seppo Pääjärvi  Tapani Aalto  Tommi Laukkanen  Tommi Somersuo
     :FOR  ${item}  IN  @{list}
     \     ${status}  ${value}=   Run Keyword And Ignore Error    Page Should Contain          ${item}
     \     Set Task Variable      ${name}  ${item}
     \     Set Task Variable     ${hour}  0
     \     Run Keyword if   '${status}' =='FAIL'   Split Names

Split Names
    [Documentation]     Splitting name variable (Created with a previous keyword) using default whitespace as separator.
          ...           Split words are returned as a list.
          ...           Using IF..ELSE condition to separate 2 and 3 parts names. THIS IS IMPORTANT TO GET EMAIL ADDRESSES IN THE RIGHT FORMAT.
          ...
     Append To File  ${CURDIR}${/}..\\..\\DynamoFiles\\namelist_mail.txt  ${name}, ${hour} ${\n}
     @{names} =	 Split String	${name}
     Set Task Variable  @{names}
     ${length} =	Get Length	${names}
     Run Keyword If    ${length}>2   Append 3 Parts Name
                        ...  ELSE    Append 2 Parts Name

Append 2 Parts Name
    [Documentation]     Appending the content to the dynamo files in the right order WHEN the name have 2 parts.
         ...
    ${email} =    Set Variable     ${names[0]}.${names[1]}@elisa.fi
    ${email} =  Replace String     ${email}    ä   a
    ${email} =  Replace String     ${email}    ö   o
    Append To File    ${CURDIR}${/}..\\..\\DynamoFiles\\mails.txt    ${email};
    Append To File    ${CURDIR}${/}..\\..\\DynamoFiles\\namelist_teams.txt  ${names[1]} ${names[0]}${\n}


Append 3 Parts Name
    [Documentation]     Appending the content to the dynamo files in the right order WHEN the name have 3 parts.
        ...
     ${email} =    Set Variable     ${names[0]}.${names[1]}${names[2]}@elisa.fi
     ${email} =  Replace String     ${email}    ä   a
     ${email} =  Replace String     ${email}    ö   o
     Append To File    ${CURDIR}${/}..\\..\\DynamoFiles\\mails.txt   ${email};
     Append To File    ${CURDIR}${/}..\\..\\DynamoFiles\\namelist_teams.txt   ${names[2]} ${names[0]} ${names[1]}${\n}
