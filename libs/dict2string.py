# encoding: utf-8
'''
    将字典类型的参数转换成用&连接的字符串类型
'''

from robot.libraries.BuiltIn import BuiltIn

class dict2string():
    def getstr(self , dct):
        if isinstance(dct, dict):
            string = ""
            for key,value in dct.iteritems():
                if string =="":
                    string = string+key+"="+value
                else:
                    string = string+"&"+key+"="+value
            return string
        else:
            return dct
if __name__=="__main__":
    p=dict2string()
    dic = {'dmacct':'test_qa1','service_code':'1'}
    print  p.getstr({'dmacct':'test_qa1','service_code':'1'})