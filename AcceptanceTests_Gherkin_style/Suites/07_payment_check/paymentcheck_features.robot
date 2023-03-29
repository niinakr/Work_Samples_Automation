*** Settings ***
Documentation
...              Note that the order with credit card payment is created on 05_ride_organazing setup by sending JSON directly to orders API 
...              Payment suite is dependant on the orderFlow-pipe (05 and 06 suites)
Resource         ../global_resources/global_resources.robot
Resource         paymentcheck_steps.robot
Suite Setup      Run Keywords     Open My Browser
...              AND  Set Strict Mode    False
...              AND  Log In To App
...              username=${CREDIT ROBOT CUSTOMER}  
...              password=${VALID PASSWORD}
Suite Teardown   Close Context 
Force Tags       paymentcheck_features   Smoke   CreditCard   orderflow


*** Test Cases ***
Customer is able to receive an email receipt for the payment
    Given Sending a GET Request to Charge Card Payment Of All Unpaid Orders
    When Customer Opens Maildev
    Then Payment Receipt Is Sent 





