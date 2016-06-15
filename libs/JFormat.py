import json
from robot.libraries.BuiltIn import BuiltIn
import base64


class JFormat():
    b = BuiltIn()

    @staticmethod
    def Jlog(formatstr, value):
        JFormat.b.log('Jstr:%s' % s, level='ERROR')

    @staticmethod
    def Jb64encode(s, altchars=None):
        return base64.b64encode(s, altchars)

    @staticmethod
    def Jb64decode(s, altchars=None):
        return base64.b64decode(s, altchars)

    @staticmethod
    def Jstr(formatstr, *value):
        return str(formatstr % value)

    @staticmethod
    def Jstr2Dict(formatstr, *value):
        return eval(formatstr % value)

    @staticmethod
    def Jjson2dict(jsonstr, flag=0):
        try:
            dict = json.loads(jsonstr)
        except Exception, ex:
            JFormat.b.log('jsonstr format wrong:%s' % ex.message, level='ERROR')
            return {}
        if (flag == 0):
            return JFormat.convert(dict)
        else:
            return dict

    @staticmethod
    def dict2jsonstr(dct):
        try:
            jsonstr = json.dumps(dct)
        except Exception, ex:
            JFormat.b.log('dict format wrong:%s' % ex.message, level='ERROR')
            return ""
        return jsonstr

    @staticmethod
    def convert(dct):
        if isinstance(dct, dict):
            return {JFormat.convert(key): JFormat.convert(value) for key, value in dct.iteritems()}
        elif isinstance(dct, list):
            return [JFormat.convert(element) for element in dct]
        elif isinstance(dct, unicode):
            return dct.encode('utf-8')
        else:
            return dct
