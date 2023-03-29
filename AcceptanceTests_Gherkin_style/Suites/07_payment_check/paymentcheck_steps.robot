*** Settings ***
Resource    ../global_resources/global_resources.robot
Library     Browser


*** Keywords ***

Sending a GET Request to Charge Card Payment Of All Unpaid Orders
    Get Charge To API

Customer Opens Maildev
    Open Fake SMTP Server
    Open Email Message     ${CREDIT ROBOT CUSTOMER} 


Payment Receipt Is Sent 
    Email Contains Valid Title     Ride receipt
    Email Contains Valid Details  pickupaddress= ${selectedStartAddress}    deliveryaddress=${selectedEndAddress}
    Email Contains Valid Service   Terminal pickup
    