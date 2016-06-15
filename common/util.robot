*** Settings ***
Documentation     公用方法
Library      DatabaseLibrary
Library      ../libs/setcode.py
Library      Collections
#Suite Setup     Connect to database
#Suite Setup     Connect to database    dbapiModuleName=MySQLdb   dbConfigFile=resources/db.cfg
#Suite Setup    Connect to database Using Custom params   pymysql    database='innodealing',user='innodealing',password='innodealing',host='192.168.8.98',port=3306
#Suite Setup    Connect to database Using Custom params   pyodbc    "Driver={MySQL ODBC 5.3 ANSI Driver};server=192.168.8.98;port=3306;database=innodealing;user=innodealing;password=innodealing;"
#Suite Teardown    Disconnect from database
*** Keywords ***
连接数据库
    [Arguments]    @{args}
    ${len}    get length    ${args}
    ${sql}    set variable if    ${len}>${0}    ${args[0]}
    ${result}    Query    ${sql}
    log    ${result}
    log    ${result[0][5]}
    [Return]  ${result}

从EXCEL中获取参数
    [Arguments]      @{args}
    ${len}    get length    ${args}
    ${filepath}    set variable if    ${len}>${0}    ${args[0]}
    ${key}    set variable if    ${len}>${1}    ${args[1]}
    set encode
    setExcelFilePath      ${filepath}
    &{dict}    getParams    ${key}
    log dictionary    ${dict}
#    ${json}    evaluate  json.dumps(${dict["jsonstr"]})    json
    ${str}    Run Keyword If     ${dict["jsonstr"]}!=None    urlencode    ${dict["jsonstr"]}
    ...    ELSE    set Variable    ""
    [Return]  ${str}
