# -*- coding:utf-8 -*-
import xlrd
import urllib,urllib2
import sys
import converStrTojson
baseurl = 'http://web.innodealing.com:8080'
xlsfile1 = r'..\libs\data\apitest.xlsx'
reload(sys)
sys.setdefaultencoding('utf8')
class RunApiTest(object):
    def api_info(self,url,data):
        req = urllib2.Request(url,data)
        response = urllib2.urlopen(req)
        return response.read()
    def excel_data(self,xlsfile):
        book = xlrd.open_workbook(xlsfile)
        api_sheet = book.sheet_by_name("Sheet1")
        nrows = api_sheet.nrows
        for i in range(23,nrows):
            api_addr = api_sheet.cell(i,0)
            formdata = api_sheet.cell(i,1)
            expect_code = str(int(api_sheet.cell(i,2).value))
            if api_sheet.cell(i,0).ctype != 0:
                url = str(api_addr.value)
            else:
                addr = api_addr.value
            data = eval(formdata.value)
            params = urllib.urlencode(data)
            code = eval(self.api_info(baseurl+url,params))
            response_code = code.get("code")
            if response_code == expect_code:
                print "pass"
            else:
                print "fail"
if __name__=="__main__":
    apitest = RunApiTest()
    apitest.excel_data(xlsfile1)