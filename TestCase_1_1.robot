*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome.exe
${CHROME_DRIVER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chromedriver.exe
${URL}    http://127.0.0.1:5500/Form.html

*** Test Cases ***
TC_001: Open Form
    [Documentation]    เปิดเว็บไซต์และตรวจสอบการแสดงแบบฟอร์ม
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}    Set Variable    ${CHROME_BROWSER_PATH}
    ${service}    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")
    # [selenium >= 4.10] chrome_options change to options
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    Go To    ${URL}
    Page Should Contain    Travel Insurance Inquiry

TC_002: Record Success
    [Documentation]    ทดสอบกรอกฟอร์มให้ครบทั้งหมดและตรวจสอบข้อความแจ้งเตือน
    Open Browser    ${URL}    Chrome
    Input Text    xpath=//input[@id='firstname']    Somsong
    Input Text    xpath=//input[@id='lastname']    Sandee
    Input Text    xpath=//input[@id='destination']    Europe
    Input Text    xpath=//input[@id='contactperson']    Sodsai Sandee
    Input Text    xpath=//input[@id='relationship']    Mother
    Input Text    xpath=//input[@id='email']    somsong@kkumail.com
    Input Text    xpath=//input[@id='phone']    081-111-1234
    Click Button    xpath=//input[@id='submitButton']
    Wait Until Page Contains    Complete
    Page Should Contain    Completed
    Page Should Contain    Our agent will contact you shortly.
    Page Should Contain    Thank you for your patient.
    Close Browser
