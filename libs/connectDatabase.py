# encoding: utf-8
import  MySQLdb
import sys
class myDataBase():
    global DATABASE_NAME
    global HOST
    global PORT
    global USER_NAME
    global PASSWORD
    global CHAR_SET
    def init(self):
        self.DATABASE_NAME = 'innodealing'
        self.HOST = '192.168.8.98'
        self.PORT = 3306
        self.USER_NAME = 'innodealing'
        self.PASSWORD = 'innodealing'
        self.CHAR_SET = 'utf8'

    def getConn(self):
        self.init()
        return MySQLdb.connect(host=self.HOST,port=self.PORT,user=self.USER_NAME,passwd=self.PASSWORD,db=self.DATABASE_NAME , charset=self.CHAR_SET)
    def getCursor(self,conn):
        return conn.cursor()
    def cur_close(self,cursor):
        if cur!= None:
             cursor.close()
    def conn_close(self,conn):
        if conn != None:
             conn.close()
    def close_database(self,conn,cur):
        self.cur_close(conn)
        self.conn_close(cur)

    def query_database(self,tablename,str=None):
        '''
        :param tablename: 数据库名称
        :param str: 查询结果中包含str的内容
        :return:如果结果包含str则返回这条数据，否则返回所有结果
        '''
        # conn = self.getConn()
        # cur =  self.getCursor(conn)
        sql = 'select * from %s'%tablename
        cur.execute(sql)
        results = cur.fetchall()
        index = cur.description
        row = {}
        result = []
        if results != None:
            if str != None:
                for res in results:
                    if str in res:
                        for i in range(len(index)-1):
                            row[index[i][0]] = res[i]
                        result.append(row)
                        return result
                    else:
                        continue
            else:
                for res in results:
                    for i in range(len(index)-1):
                        row[index[i][0]]= res[i]
                    result.append(row)
                return result


if __name__=='__main__':
    database = myDataBase()
    conn = database.getConn()
    cur = database.getCursor(conn)
    result =  database.query_database('t_user')
    print result
    conn.commit()
    cur.close()
    conn.close()
