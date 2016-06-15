 # encoding: utf-8

import SheetManager
import xlrd


#单表模式
def singlebook(file_path,output_dir='./'):

    SheetManager.addWorkBook(file_path)
    sheetNameList = SheetManager.getSheetNameList()

    for sheet_name in sheetNameList:
        #单表模式下，被引用的表不会输出
        if SheetManager.isReferencedSheet(sheet_name):
            continue

        sheetJSON = SheetManager.exportJSON(sheet_name)
        return sheetJSON

        f = file(output_dir+sheet_name+'.json', 'w')
        f.write(sheetJSON.encode('UTF-8'))
        f.close()

#主表模式
def mainbook(file_path,output_dir='./'):

    #获取主表各种参数#
    wb = xlrd.open_workbook(file_path)
    sh = wb.sheet_by_index(0)

    workbookPathList = []
    sheetList = []
    for row in range(sh.nrows):
        type = sh.cell(row,0).value

        if type == '__workbook__':
            pass
        else:
            sheetList.append([])
            sheet = sheetList[-1]
            sheet.append(type)

        for col in range(1,sh.ncols):
            value = sh.cell(row,col).value

            if type == '__workbook__' and value != '':
                workbookPathList.append(value)
            elif value != '':
                sheet.append(value)

    #加载所有xlsx文件#
    for workbookPath in workbookPathList:
        #读取所有sheet
        SheetManager.addWorkBook(workbookPath + ".xlsx")

    #输出所有表#
    for sheet in sheetList:

        #表改名处理
        if '->' in sheet[0]:
            sheet_name = sheet[0].split('->')[0]
            sheet_output_name = sheet[0].split('->')[1]
        else:
            sheet_output_name = sheet_name = sheet[0]

        sheet_output_field = sheet[1:]

        sheetJSON = SheetManager.exportJSON(sheet_name, sheet_output_field)

        f = file(output_dir+sheet_output_name+'.json', 'w')
        f.write(sheetJSON.encode('UTF-8'))
        f.close()

if __name__ == '__main__':
    print singlebook('12.xlsx')
