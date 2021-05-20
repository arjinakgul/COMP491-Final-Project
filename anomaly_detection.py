import urllib.request
import json
import os
import ssl
import talib
import numpy as np
import os.path, time
import requests
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore


##FIRESTORE
cred = credentials.Certificate("C:/Users/ardad/Desktop/molybot-650c9-firebase-adminsdk-vwmfr-e84aef6efc.json")
firebase_admin.initialize_app(cred, {
  'projectId': "molybot-650c9",
})

db = firestore.client()


urlbinance="https://api.binance.com/api/v3/ticker/price"
paramETH={'symbol':'ETHUSDT'}

def allowSelfSignedHttps(allowed):
    # bypass the server certificate verification on client side
    if allowed and not os.environ.get('PYTHONHTTPSVERIFY', '') and getattr(ssl, '_create_unverified_context', None):
        ssl._create_default_https_context = ssl._create_unverified_context



allowSelfSignedHttps(True) # this line is needed if you use self-signed certificate in your scoring service.

# Request data goes here

rates=[]

while(True):

    now=round(float(time.time()))
    f = open("closeprice.txt", "r")
    f2 = open("highprice.txt", "r")
    f3 = open("lowprice.txt", "r")
    text=list(map(float,f.read().split("\n")[:-1]))
    text2=list(map(float,f2.read().split("\n")[:-1]))
    text3=list(map(float,f3.read().split("\n")[:-1]))


    arr=np.array(text)  #close
    arr2=np.array(text2)  #hi
    arr3=np.array(text3)   #lo
    
 

    output= talib.RSI(arr, timeperiod=15)
    output2=talib.ATR(arr2,arr3,arr,timeperiod=15)
    output3=talib.AROONOSC(arr2, arr3, timeperiod=15)

    # print(output3)

    r = requests.get(url = urlbinance, params = paramETH) 
    res=r.json()
    rate=res["price"]
    
    rates.append(rate)

    #b'{"Results": {"WebServiceOutput0": [{"rsi": 55.327626044097414, "atr": 12.400186352929014, "aroon": 0.0, "prate": 3763.26, "crate": 3771.14, "Scored Labels": 3766.68875}]}}'

    if len(rates)==11:
        print(output[-1],output2[-1],output3[-1],rates[0],rates[10])
        data = {
            "Inputs": {
                "WebServiceInput0":
                [
                    {
                        'rsi': output[-1],
                        'atr': output2[-1],
                        'aroon': 0.0,
                        'prate': rates[0],
                        'crate': rates[10]
                    },
                ],
            },
            "GlobalParameters": {
            }
        }

        

        body = str.encode(json.dumps(data))

        url = 'azure container url'
        api_key = 'webservice api key' # Replace this with the API key for the web service
        headers = {'Content-Type':'application/json', 'Authorization':('Bearer '+ api_key)}

        req = urllib.request.Request(url, body, headers)

        try:
            response = urllib.request.urlopen(req)

            result = response.read().decode('utf-8')
            json_obj=json.loads(result)
            output=json_obj["Results"]["WebServiceOutput0"][0]
            crate=output["crate"]
            scored_label=output["Scored Labels"]
            
            
            if abs(float(crate)-float(scored_label))/crate >= 0.04:
               
                
                db.collection("alarm").add({
                    "name": "ETHUSDT",
                    "time": time.time()
                })

        except urllib.error.HTTPError as error:
            print("The request failed with status code: " + str(error.code))

    # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
            print(error.info())
            print(json.loads(error.read().decode("utf8", 'ignore')))

        

        rates=rates[1:]
    time.sleep(600)