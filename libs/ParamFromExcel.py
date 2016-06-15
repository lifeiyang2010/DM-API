# encoding: utf-8
import os

from ExcelAndJson.execlNjson import singlebook
import json
from robot.libraries.BuiltIn import BuiltIn



class ParamFromExcel():
    #b = BuiltIn()

    def __init__(self):
        self.filepath = None
        self.params = None
        self.json = None

    def setExcelFilePath(self,path):
        self.filepath = path
        self.params = singlebook(os.getcwd() + self.filepath)
        # self.params = singlebook(os.getcwd() +r"..\data\im-api.xlsx")
        self.json = json.loads(self.params)

    def getParams(self, key):
        return self.Jconvert(self.json[key])

    def Jconvert(self, dct):
        if isinstance(dct, dict):
            return {self.Jconvert(key): self.Jconvert(value) for key, value in dct.iteritems()}
        elif isinstance(dct, list):
            return [self.Jconvert(element) for element in dct]
        elif isinstance(dct, unicode):
            return dct.encode('utf-8')
        else:
            return dct


if __name__ == '__main__':
    p = ParamFromExcel()
    #p.getParams(u'/im-service/imapi/smsOffLineHandler/selectSMSOffLineInfo')
    p.setExcelFilePath("./data/im-api.xlsx")
    p.getParams(u'/im-service/imapi/sessionhistoryHandler/getSessionhistoryListByFlag')

