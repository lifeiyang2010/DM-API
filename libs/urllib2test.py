import  urllib2
import urllib

def post(url,data):
    data = urllib.urlencode(data)
    req = urllib2.Request(url,data)
    #opener = urllib2.build_opener(urllib2.HTTPCookieProcessor())
  #  response = opener.open(req, data)
    response = urllib2.urlopen(req)
    return response.read()
def main():
    url = "http://web.innodealing.com:8080/im-service/imapi/smsOffLineHandler/selectSMSOffLineInfo"
    data = {'dmacct':'test_qa1','service_code':'1'}
    print post(url,data)

if __name__ == '__main__':
    main()