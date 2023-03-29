@echo off
call robot --output original.xml -d %~dp0\..\Results\Dynamo-Suite %~dp0\..\Suites\01__Dynamo-Suite\01__Dynamo_Task.robot
call robot --rerunfailedsuites %~dp0\..\Results\Dynamo-Suite\original.xml --output rerun.xml -d %~dp0\..\Results\Dynamo-Suite %~dp0\..\Suites\01__Dynamo-Suite\01__Dynamo_Task.robot
call robot --output original.xml -d %~dp0\..\Results\Outlook-Suite %~dp0\..\Suites\03__Outlook-Suite\03__Outlook_Task.robot
call robot --rerunfailedsuites %~dp0\..\Results\Outlook-Suite\original.xml --output rerun.xml -d %~dp0\..\Results\Outlook-Suite %~dp0\..\Suites\03__Outlook-Suite\03__Outlook_Task.robot
