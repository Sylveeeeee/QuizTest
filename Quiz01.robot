*** Settings ***
Library            SeleniumLibrary
Suite Setup        Open Browser    http://automationexercise.com    Chrome
Suite Teardown     Close Browser

*** Variables ***
${SEARCH_PRODUCT}    Tshirt
${USERNAME}          mmm123@gmail.com
${PASSWORD}          111111

*** Keywords ***
Navigate To Products Page
    Click Element    xpath=//*[@id="header"]/div/div/div/div[2]/div/ul/li[2]/a
    Wait Until Element Is Visible    xpath=/html/body/section[2]/div/div/div[2]/div/h2
    Page Should Contain    All Products

Search For Product
    Input Text    xpath=//*[@id="search_product"]    ${SEARCH_PRODUCT}
    Click Button    xpath=//*[@id="submit_search"]
    Wait Until Element Is Visible    xpath=/html/body/section[2]/div/div/div[2]/div/h2
    Page Should Contain    Searched Products

Verify And Add Searched Products To Cart
    ${products}=    Get WebElements    xpath=/html/body/section[2]/div/div/div[2]/div/div[2]
    FOR    ${product}    IN    @{products}
        Click Element    xpath=/html/body/section[2]/div/div/div[2]/div/div[2]/div/div[1]/div[1]/a
        Sleep    2s
    END

Go To Cart And Verify Products
    Run Keyword And Ignore Error    Click Element    xpath=//*[@id="cartModal"]/div/div/div[3]/button
    Wait Until Element Is Not Visible    xpath=//*[@id="cartModal"]    timeout=5s
    Click Element    xpath=//*[@id="header"]/div/div/div/div[2]/div/ul/li[3]/a
    Wait Until Element Is Visible    xpath=//*[@id="cart_info_table"]
    Page Should Contain    ${SEARCH_PRODUCT}

Login To Website
    Click Element    xpath=//*[@id="header"]/div/div/div/div[2]/div/ul/li[4]/a
    Wait Until Element Is Visible    xpath=//*[@id="form"]/div/div/div[1]/div
    Input Text    xpath=//*[@id="form"]/div/div/div[1]/div/form/input[2]    ${USERNAME}
    Input Text    xpath=//*[@id="form"]/div/div/div[1]/div/form/input[3]    ${PASSWORD}
    Click Button    xpath=//*[@id="form"]/div/div/div[1]/div/form/button
Verify Cart After Login
    Click Element    xpath=//*[@id="header"]/div/div/div/div[2]/div/ul/li[3]/a
    Wait Until Element Is Visible    xpath=//*[@id="cart_info_table"]
    Page Should Contain    ${SEARCH_PRODUCT}

*** Test Cases ***
TC20 - Search Products and Verify Cart After Login
    Navigate To Products Page
    Search For Product
    Verify And Add Searched Products To Cart
    Go To Cart And Verify Products
    Login To Website
    Verify Cart After Login
