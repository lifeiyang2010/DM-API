# encoding: utf-8
import sys

class setcode():

    def set_encode(self):
        reload(sys)
        sys.setdefaultencoding('utf8')
    def resetencode(self,str):
        reload(sys)
        sys.setdefaultencoding('utf8')
        str1=str.decode('utf-8').encode('gb2312')
        print str1
        return str1

if __name__=="__main__":
    p=setcode()
    print p.resetencode("我是中文")