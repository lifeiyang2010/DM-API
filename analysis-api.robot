*** Settings ***
Documentation     app-im 接口测试
Library           HttpLibrary.HTTP
Library           Collections
Library           urllib
Library           libs/ParamFromExcel.py
Library           json
Resource          common/util.robot

*** Variables ***
${host}           web.innodealing.com:8080
${filepath}       ./data/analysis-api.xlsx

*** Test Cases ***
当日实时申购行情
    ${response}    Analysis接口API    /api/bond/applyinfo
    log    ${response}

非金融企业债务融资工具估值曲线
    ${response}    Analysis接口API    /api/bond/valuation
    log    ${response}

报价分布
    ${response}    Analysis接口API    /api/distribution/distridata
    log    ${response}

期限结构趋势图
    ${response}    Analysis接口API    /api/distribution/tenordaily
    log    ${response}

获取指导价
    ${response}    Analysis接口API    /api/guideprice/dailydata
    log    ${response}

获取指导价的最高价中间价最低价
    ${response}    Analysis接口API    /api/guideprice/dailydatasummary
    log    ${response}

获取历史指导价，返回指定所有历史数据
    ${response}    Analysis接口API    /api/guideprice/historydata1
    log    ${response}

获取历史指导价，返回所有期限历史数据
    ${response}    Analysis接口API    /api/guideprice/historydata2
    log    ${response}

获取票据回购转贴指导价
    ${response}    Analysis接口API    /api/guideprice/ticket
    log    ${response}

资金供需比/选1月、3月、6月
    ${response}    Analysis接口API    /api/ratio/all
    log    ${response}

资金供需比/选1天曲线时
    ${response}    Analysis接口API    /api/ratio/day
    log    ${response}

资金供需比/界面
    ${response}    Analysis接口API    /api/ratio/record
    log    ${response}

今日shibor(结果经过封装后的)
    ${response}    Analysis接口API    /api/shibor/dailydata
    log    ${response}

今日shibor(结果未经过封装后的,原生的sql结果集)
    ${response}    Analysis接口API    /api/shibor/dailydataNative
    log    ${response}

Shibor曲线
    ${response}    Analysis接口API    /api/shibor/historydatas
    log    ${response}


*** Keywords ***
Analysis接口API
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
    接口返回结果校验    ${result}
    [Return]    ${result}    ${status_code}

转换成url请求字符串
    [Arguments]     @{args}
    ${len}    get length    ${args}
    ${body}    Run Keyword If    ${len}>${0}    evaluate   ${args[0]}
    ${str}    urlencode    ${body}
    [Return]     ${str}

接口返回结果校验
    [Arguments]    ${responsejson}
    log    ${responsejson}
    Should Be Valid JSON    ${responsejson}
    &{result}    loads    ${responsejson}
    log    ${result["code"]}
    Run Keyword If    "${result["code"]}" !="0"    Fail
    Run Keyword If    "${result["message"]}" !="success"    Fail
