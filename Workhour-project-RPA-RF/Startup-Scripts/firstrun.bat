@echo off
call robot --output original.xml -d %~dp0\..\Results\Dynamo-Suite %~dp0\..\Suites\01__Dynamo-Suite\01__Dynamo_Task.robot
call robot --rerunfailedsuites %~dp0\..\Results\Dynamo-Suite\original.xml --output rerun.xml -d %~dp0\..\Results\Dynamo-Suite %~dp0\..\Suites\01__Dynamo-Suite\01__Dynamo_Task.robot
call robot --output original.xml -d %~dp0\..\Results\Teams-Suite %~dp0\..\Suites\02__Teams-Suite\02__Teams_Task.robot
call robot --rerunfailedsuites %~dp0\..\Results\Teams-Suite\original.xml --output rerun.xml -d %~dp0\..\Results\Teams-Suite %~dp0\..\Suites\02__Teams-Suite\02__Teams_Task.robot
