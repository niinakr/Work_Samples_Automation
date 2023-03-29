*** Settings ***
Documentation     Resource file
Library   SeleniumLibrary
Variables          ${CURDIR}${/}..\\..\\credentials.py

*** Variables ***
#************************** Common Variables ******************************
${URL}      https://mail1.elisa.fi/
${TEAMSCHANNEL}            be77682d.groups.elisa.com@emea.teams.ms;

#************************** Locators *********************************#
${USERNAME_PATH}    xpath=//*[@id="username"]
${PASSWORD_PATH}    xpath=//*[@id="password"]
${SIGNIN_BUTTON_PATH}   xpath=//*[@class="signinbutton"]
${NEWMAIL}      //button[@class="_fce_h _fce_f ms-fwt-r ms-fcl-np o365button"]
${TO_PATH}     xpath=//*[@id="primaryContainer"]/div[5]/div/div[1]/div/div[5]/div[3]/div/div[5]/div[1]/div/div[3]/div[4]/div/div[1]/div[2]/div[2]/div[1]/div[1]/div[2]/div[2]/div[1]/div/div/div/span/div[1]/form/input
${SUBJECT_PATH}     xpath=//*[@id="primaryContainer"]/div[5]/div/div[1]/div/div[5]/div[3]/div/div[5]/div[1]/div/div[3]/div[4]/div/div[1]/div[2]/div[2]/div[1]/div[1]/div[2]/div[6]/div[2]/input
${MESSAGE_PATH}     xpath=//*[@id="primaryContainer"]/div[5]/div/div[1]/div/div[5]/div[3]/div/div[5]/div[1]/div/div[3]/div[4]/div/div[1]/div[2]/div[2]/div[2]/div[3]/div/div[3]/div[1]/div[3]/div
${SEND_BUTTON_PATH}    xpath=//*[@class="_mcp_62 o365button o365buttonOutlined ms-font-m ms-fwt-sb ms-fcl-w ms-bgc-tp ms-bcl-tp ms-bgc-td-f ms-bcl-tdr-f"]
${SUPERIORS_MAILS}   Tommi.Somersuo@elisa.fi;Tuomas.Jokimaa@elisa.fi;

*** Keywords ***
End Task
    Close Browser
