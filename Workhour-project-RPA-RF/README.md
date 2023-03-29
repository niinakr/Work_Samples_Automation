<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Robot-framework-logo.png/250px-Robot-framework-logo.png" width="256" title="Github Logo">
</p>

# RPA: WORKHOUR PROJECT (MAURI)
Robot Framework project for RPA-purpose. Main goal is try to use Robot Framework in RPA and automate people managers workhour process.
Discussion about this project is based on [Microsoft Teams (Private)](https://teams.microsoft.com/l/channel/19%3ad21dd15fdcff41a7b550a93d44110f67%40thread.skype/Elisa%2520Internal%2520case?groupId=b7597dea-5deb-4677-a5f4-e4af92f3b388&tenantId=bc70102e-bcef-408c-8acb-2ab01f1517ab).


### Structure of files
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


```

## Workflow of tasks

![workflow](https://github.com/niinakr/Work_Samples_Automation/blob/main/Workhour-project-RPA-RF/images/Flow%20Chart%20-%20Check%20weekly%20hours.jpg)


