*** Settings ***
Documentation    Suite description
Library      HttpLibrary.HTTP
Library      Collections
Library      libs/ParamFromExcel.py
Library      libs/setcode.py
Library      urllib
Library      json
Resource     common/util.robot
Suite Setup     Connect to database
#Suite Setup    Connect to database Using Custom params   pyodbc    "Driver={MySQL ODBC 5.3 ANSI Driver};server=192.168.8.98;port=3306;database=innodealing;user=innodealing;password=innodealing;"
Suite Teardown    Disconnect from database

*** Variables ***
${host}    web.innodealing.com:8080
${filepath}    ./data/im-api.xlsx

*** Test Cases ***
查询离线短信通知设置
    ${response}    IM系统API    /im-service/imapi/smsOffLineHandler/selectSMSOffLineInfo
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success


查询单聊历史聊天记录
    ${response}    IM系统API    /im-service/imapi/messageHandler/getHistoryMessage
    log    ${response}
    ${res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

更改离线短信通知设置
    ${response}    IM系统API  /im-service/imapi/smsOffLineHandler/updateSMSOffLineInfo
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0

文件下载
    ${response}    IM系统API  /im-service/imapi/mongodbGridFSHandler/downloadFromMongodb
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

消息管理器获取个人聊天记录
    ${response}    IM系统API    /im-service/imapi/messageManageHandler/getNormalMessage
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

消息管理器获取群聊天记录
    ${response}    IM系统API      /im-service/imapi/messageManageHandler/getGroupMessage
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

消息管理器获取系统消息记录
    ${response}    IM系统API    /im-service/imapi/messageManageHandler/getSysMessage
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success


获取推荐好友
    ${response}    IM系统API     /im-service/imapi/userSearchHandler/recommendFriendList
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

获取广播次数
    ${response}    IM系统API     /im-service/imapi/sysuserBroadcastHandler/broadcastTimes
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

创建广播
    ${response}    IM系统API    /im-service/imapi/broadcastHandler/createBroadcast
    log    ${response}
    &{res1}    loads    ${response}
    Should be equal as Strings    ${res1["code"]}   0

消息管理器全文搜索
    ${response}    IM系统API     /im-service/imapi/messageManageHandler/getMMResultByKeyword
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

获取推荐群
    ${response}    IM系统API     /im-service/imapi/userSearchHandler/recommendTroopList
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

匿名报价接口
    ${response}    IM系统API      /im-service/imapi/quoteAnonymousHandler/getQuoteAnonymousHistory
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

询价历史消息
    ${response}    IM系统API     /im-service/imapi/messageHandler/getEnquiryHistoryMessage
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

消息管理器获取询价聊天的联系人列表
    ${response}    IM系统API     /im-service/imapi/messageManageHandler/getEnquiryList
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

消息管理器获取具体询价聊天历史纪录
    ${response}    IM系统API      /im-service/imapi/messageManageHandler/getEnquiryMessages
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

匿名人取消匿名
    ${response}    IM系统API    /im-service/imapi/quoteAnonymousHandler/saveQuoteAnonymousHistory
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    -1

撤销广播（后台）
    ${response}    IM系统API      /im-service/imapi/broadcastHandler/cancel
    log    ${response}
    Should be equal as Strings    ${response}    true

根据关键字查询非黑名单外的全站用户
    ${response}    IM系统API     /im-service/imapi/userSearchHandler/getAllUserWithoutScreen
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success


查询群聊历史聊天记录
    ${response}    IM系统API     /im-service/imapi/messageHandler/getHistoryTroopMessage
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success


消息管理器查询历史的关系（单聊、群聊、广播。注：目前只用于查询“群聊”）
    ${response}    IM系统API     /im-service/imapi/sessionhistoryHandler/getSessionhistoryListByFlag
    log    ${response}
    &{res}    loads    ${response}
    Should be equal as Strings    ${res["code"]}    0
    Should be equal as Strings    ${res["message"]}    success

测试连接数据库
    ${result}    连接数据库    select * from t_user
    log    ${result}

*** Keywords ***
IM系统API
    [Arguments]    @{args}
    ${len}     get length    ${args}
    ${path}    set variable if  ${len}>${0}    ${args[0]}
    ${body}    从EXCEL中获取参数    ${filepath}    ${path}
#    set encode
    create http context    ${host}    http
    set request header    Content-Type    application/x-www-form-urlencoded
    set request body    ${body}
    log many   ${path}    ${body}
    post    ${path}
    log response body
    ${resultBody}    get response body
    [Return]    ${resultBody}



