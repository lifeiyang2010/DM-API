*** Settings ***
Documentation     app-im 接口测试
Library           HttpLibrary.HTTP
Library           Collections
Library           urllib
Library           libs/ParamFromExcel.py
Library           json
Resource          common/util.robot

*** Variables ***
#${host}           192.168.8.98:19082
${host}           web.innodealing.com:8080
${filepath}       ./data/app-api.xlsx

*** Test Cases ***
app获取所有好友
#    ${response}    ${status_code}    APP接口API    /im-service/imapi/userSearchHandler/getAllFriendList    {'dmacct':'test_qa1','name':'test_qa2','pageindex':'0','pagesize':'30'}
    ${response}    ${status_code}    APP接口API    /im-service/imapi/userSearchHandler/getAllFriendList
    log    ${response}

app根据手机号找回用户
    ${response}    APP接口API    /im-service/imapi/sysUserHandler/getSysuerByMobile
    log    ${response}

查询不在某群的个人的所有分组和分组下的所有人
    ${response}    APP接口API    /im-service/imapi/userSearchHandler/getGroupsAndUserListWithoutRoomjid
    log    ${response}

app查询人物页面接口
    ${response}    APP接口API    /im-service/imapi/userSearchHandler/getAllResultsForApp
    log    ${response}

*** Keywords ***
APP接口API
    [Arguments]    @{args}
    ${len}    get length    ${args}
    ${path}    set variable if    ${len}>${0}    ${args[0]}
    ${body}    Run Keyword If    ${len} == ${1}    从EXCEL中获取参数    ${filepath}    ${path}
    ...    ELSE IF    ${len}>${1}    转换成url请求字符串    ${args[1]}
    log    ${body}
    create http context    ${host}    http
    set request body    ${body}
    set request header    Content-Type    application/x-www-form-urlencoded
    log many    ${path}    ${body}
    post    ${path}
    log response body
    ${result}    get response body
    ${status_code}    get response status
    APP接口返回结果校验    ${result}
    [Return]    ${result}    ${status_code}

转换成url请求字符串
    [Arguments]     @{args}
    ${len}    get length    ${args}
    ${body}    Run Keyword If    ${len}>${0}    evaluate   ${args[0]}
    ${str}    urlencode    ${body}
    [Return]     ${str}

APP接口返回结果校验
    [Arguments]    ${responsejson}
    log    ${responsejson}
    Should Be Valid JSON    ${responsejson}
    &{result}    loads    ${responsejson}
    log    ${result["code"]}
    Run Keyword If    "${result["code"]}" !="0"    Fail
    Run Keyword If    "${result["message"]}" !="success"    Fail
