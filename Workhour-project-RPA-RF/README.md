<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Robot-framework-logo.png/250px-Robot-framework-logo.png" width="256" title="Github Logo">
</p>

# RPA: WORKHOUR PROJECT (MAURI)
Robot Framework project for RPA-purpose. Main goal is try to use Robot Framework in RPA and automate people managers workhour process.
Discussion about this project is based on [Microsoft Teams (Private)](https://teams.microsoft.com/l/channel/19%3ad21dd15fdcff41a7b550a93d44110f67%40thread.skype/Elisa%2520Internal%2520case?groupId=b7597dea-5deb-4677-a5f4-e4af92f3b388&tenantId=bc70102e-bcef-408c-8acb-2ab01f1517ab). Read the Process workflow from here: [Elisa Internal RPA case](https://github.devcloud.elisa.fi/Appelsiini/Workhour-project-RPA/wiki/Elisa-internal-RPA-case)

## TABLE OF CONTENTS
* [Robot Framework](#robot-framework)
* [Getting Started](#getting-started)
* [Infrastructure](#infrastructure)

## ROBOT FRAMEWORK

###  Workflows
There are two workflows:


   **First Check:**  Opens Dynamo hour report and gets the names and emails of people who has missing work hours from last week (less than 36 hours) --> Sends email (via Microsoft Outlook) to Microsoft Teams channel (Software Project - General) and private email as a reminder to these people.

   **Second Check:** Opens Dynamo hour report and gets the names and emails of people who have missing work hours from last week (less than 36 hours) --> Sends a  private Outlook message to Superiors including the names of people who have missing work hours.

![workflow](https://github.devcloud.elisa.fi/Appelsiini/Workhour-project-RPA/blob/master/images/Flow%20Chart%20-%20Check%20weekly%20hours.jpg)

###  Suites
Test case files, as well as the resources files, are located in the `Suites` directory. Resource files contain the logic of task (keywords and variables). Task files contain the workflow of tasks. Click file names below to see the latest versions.

[01__Dynamo_Suite](https://github.devcloud.elisa.fi/Appelsiini/Workhour-project-RPA/tree/master/Suites/01__Dynamo-Suite)


 This task opens dynamo hour report and gets the names and emails of people who have missing work hours from last week (less than 36 hours). 

 This task has a workflow that is created using the keywords in Dynamo_Resource file.

[02__Teams_Suite](https://github.devcloud.elisa.fi/Appelsiini/Workhour-project-RPA/tree/master/Suites/02__Teams-Suite)


This task sends Teams message to the general channel and private Outlook message as a reminder to people who have missing work hours from last week.
 
This task has a workflow that is created using the keywords in Teams_Resource file.

[03__Outlook-Suite](https://github.devcloud.elisa.fi/Appelsiini/Workhour-project-RPA/tree/master/Suites/03__Outlook-Suite)


This task sends a  private outlook message to Superiors including the names of people who have missing work hours from last week. 

This task has a workflow that is created using the keywords in Teams_Resource file.

### Structure of tasks
```
Workhour-project-RPA 
|----Suites
  |---01__Dynamo-Suite
  |  |----Dynamo_Resource.robot
  |  |----01__Task_Dynamo.robot	
  | 
  |  
  |----02__Teams-Suite
  |  |----Outlook_Resource.robot
  |  |----02__Task_Teams.robot	
  |  
  |
  |----03__Outlook-Suite
  |   |----Teams_Resource.robot
  |   |----03__Task_Outlook.robot
  |   
  |
  |----Global_Resources
      |----Global_resource.robot      #Shared resources
|
|----DynamoFiles                      #Output of Dynamo task
|----Reports                          #Output of Robot Framework
|----Startup-Scripts                  #Two startup scripts for both workflows


Workflows:
1. Dynamo Suite + Teams Suite
2. Dynamo Suite + Outlook Suite
```

## GETTING STARTED
 
### Installing

Installation steps:
* Install Python 3.6+ & PIP (Add to your PATH)
* Use PIP to install Robot Framework 3.1.1+ [Github](https://github.com/robotframework)
* Use PIP to install SeleniumLibrary 3.3.1+ [Github](https://github.com/robotframework/SeleniumLibrary)
* Install ChromeDriver2.45+ (Add to your PATH) [Install ChromeDriver](http://chromedriver.chromium.org/downloads)
* Git
* Code editor (e.g. Visual Code or PyCharm)

###  How to run

IMPORTANT! Before you can run any tasks you have to fill the usernames and password in Crendentials.py (in ROOT directory). If you want to move it somewhere else change the path in` Global_resouce.robot`:  

```
*** Settings ***
Variables     path/to/your/file/credentials.py
```

**1. On-demand** 

There are two different scripts for both workflows in /Startup-Scripts directory.  Just Double click the file to execute. See the results from /Result directory. 

**2. Scheduler**
* Open windows task scheduler
* Create a new task
* Point the startup scripts
* Triggering on scheduled


## INFRASTRUCTURE 

![workflow](https://github.devcloud.elisa.fi/Appelsiini/Workhour-project-RPA/blob/master/images/infrastructure.JPG)


## AUTHORS
* Pekka Pönkänen (ponkape)
* Niina Rantanen (rantani)
