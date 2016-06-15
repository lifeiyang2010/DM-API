# encoding: utf-8
from ExcelAndJson.JuneDetectChars import is_normal


def convertstrtojson(jstr):
        dict = {}
        list = jstr.split(',')
        print jstr,list
        for i in range(len(list)):
            kv = list[i].split(':')
            key = kv[0]
            value = kv[1]

            if value.isdigit() and '.' in value:
                dict[key] = float(value)
            elif value.isdigit():
                dict[key] = int(value)
            else:
                dict[key] = value

        return dict


if __name__=="__main__":
    print convertstrtojson('{"code":"0","totalnumber":"","datas":"null","message":"mongodb group message is null"}')

