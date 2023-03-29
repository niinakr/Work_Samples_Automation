*** Settings ***
Documentation
...               Keywords in the helper file describe actions via a test library to interact with the application under test.
...               Variables in the helpers are typically locators of elements
Resource         ../global_resources/global_resources.robot


*** Keywords ***
Open Ordering View
    Click Menubar
    Wait For Elements State          //*[@data-test-id = "orders-link"]   visible
    Click                            //*[@data-test-id = "orders-link"]

Click To Open Order Form
    Wait For Elements State          //*[name()='svg']//*[contains(@d,'M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z')]  visible
    Click                            //*[name()='svg']//*[contains(@d,'M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z')]
    Wait For Elements State          //*[@id = "passenger-user-guid"]                                          visible

Select Passenger On Order Dialog
    [Arguments]                      ${customername}
    Press Keys                       css=div[data-testid="order-modal"]        Tab+Enter
    Wait For Elements State          //*[@aria-labelledby="passenger-user-guid"]
    Click                            xpath=.//li[contains(., "${customername}")]

Input Time
    [Arguments]                      ${input_date}                                    ${input_time}
    Focus                            id=plannedPickupDatePicker
    Fill Text                        id=plannedPickupDatePicker                       ${input_date} ${input_time}

Input Car Type
    [Arguments]                      ${vehicleClass}
    Click                            css=div[aria-labelledby="requested-vehicle-class-guid"]
    Click                            xpath=.//li[contains(., "${vehicleClass}")]

Input Payment Type
    [Arguments]                      ${paymentType}
    Click                            css=div[id="mui-component-select-paymentType"]
    IF  '${paymentType}' == 'Credit Card'
        Click                        li[data-test-id="credit-card-payment-type"]
        Wait For Elements State      div[id="mui-component-select-paymentCreditCardGuid"]       visible
        Click                        div[id="mui-component-select-paymentCreditCardGuid"]
        Wait For Elements State      ul[aria-labelledby="payment-card"] li:first-of-type       visible
        Click                        ul[aria-labelledby="payment-card"] li:first-of-type
    ELSE
        Click                        li[data-test-id="invoice-payment-type"]
    END

Input Number Of Passengers
    [Arguments]                      ${input}
    Wait For Elements State          //*[@name = "numberOfPassengers"]       visible
    Fill Text                        //*[@name = "numberOfPassengers"]       ${input}

Add Additional Destinations
    [Arguments]                  ${nroOfDestinations}
    ${additionalDestinations}    Create List            ${EMPTY}
    Set Suite Variable           ${additionalDestinations}    ${additionalDestinations}
    FOR    ${counter}    IN RANGE    2    ${nroOfDestinations} + 2
        Click    text=Lisää uusi kohde
        Wait Until Input For Additional Destination Is Visible    ${counter}
        Select Random Additional Address    ${counter}
        Wait For Response        matcher=${APP_URL.${ENVIRONMENT}}api/pricing/
        Sleep    1s
    END
    Log To Console               \n Additional destinations:\n${additionalDestinations}

Confirm Order Is Created
    Wait For Elements State             text=Tilauksen luonti onnistui    visible    timeout=30s

Submit Order Form
    Wait For Elements State             //*[@data-test-id = "saveOrderButton"]    enabled
    Click                               //*[@data-test-id = "saveOrderButton"] 

Choose Email Booking Confirmation
    Wait For Elements State             //*[@data-test-id = "requestEmailConfirmationCheckbox"]
    Click                               //*[@data-test-id = "requestEmailConfirmationCheckbox"]
    Click                               //*[@data-test-id = "sendOrderButton"]

Don't Choose Email Booking Confirmation
    Wait For Elements State             //*[@data-test-id = "requestEmailConfirmationCheckbox"]
    Click                               //*[@data-test-id = "sendOrderButton"]

Go To Next Week View
    Click                               xpath=//*[@data-test-id = "weekbrowser-next-button"]

Order Should Be Visible
    [Arguments]                       ${pickupaddress} 
    Get Element State                 text= ${pickupaddress}     visible

Click Save
    Click                            //*[@data-test-id = "saveOrderButton"]
    Get Text                         text=Tilauksen tallennus onnistui

Cancel The Ride
    Wait For Elements State          //*[@data-test-id = "cancelOrderButton"]    visible
    Click                            //*[@data-test-id = "cancelOrderButton"]
    Click                            //*[@data-test-id = "confirmCancelOrderButton"]
    Get Text                         text=Ajo peruutettu onnistuneesti

Add Additional Information 
    [Arguments]                      ${input}
    Wait For Elements State          //*[@name = "additionalInformation"]       visible
    Fill Text                        //*[@name = "additionalInformation"]       ${input}


