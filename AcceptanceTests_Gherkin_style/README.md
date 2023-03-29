<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Robot-framework-logo.png/250px-Robot-framework-logo.png" width="256" title="Github Logo">
</p>

# RF Gherkin Test Automation Project For Edustusautot
Robot Framework test automation for EdustusautotApp.

### Structure of files
```
AcceptanceTests
|----Suites
  |---Login_features
  |  |----login_features.robot        #Testcases in Gherkin format (Given/When/Then)
  |  |----login_steps.robot           #Implementation of the Gherkin test
  |  |----login_helpers.robot         #Interaction with GUI via page object model
  |  |----__init__.robot
  |  
  |----Registration_features
  |  |----registration_features.robot
  |  |----registration_steps.robot
  |  |----registration_helpers.robot 
  |  |----__init__.robot
  |
  |----...etc.
  |   |--- ...
  |   |--- ...
  |   |---- __init__.robot
  |
  |----Global_resources              #Shared resources
      |-----Global_variables.robot  
      
|----Results                          #Output of Robot Framework


```
###  Workflow of tests

![](Img/FlowChartUpdated.jpg)


