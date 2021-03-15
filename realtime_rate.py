
from binance.websockets import BinanceSocketManager
import pprint
from firebase import firebase
import time
from binance.client import Client



firebase = firebase.FirebaseApplication("enter your firebase url", None)
key = "enter your Binance API Key"
secret = "enter your Binance secret key"

client = Client(key, secret)
info = client.get_exchange_info()



bm = BinanceSocketManager(client)

def process_messageETH(msg):
    noweth=round(time.time() * 1000)
    firebase.post("/rates/ETHUSDT", (msg["k"]["c"],msg["E"]))
    db=firebase.get("/rates/ETHUSDT",None)
    k=list(db.keys())[0]
    a=db[k]
    if noweth-a[1]>3600000:
        firebase.delete("/rates/ETHUSDT",k)


def process_messageBTC(msg):
	
    nowbtc=round(time.time() * 1000)
    firebase.post("/rates/BTCUSDT", (msg["k"]["c"],msg["E"]))
    db=firebase.get("/rates/BTCUSDT",None)
    k=list(db.keys())[0]
    a=db[k]
    if nowbtc-a[1]>3600000:
        firebase.delete("/rates/BTCUSDT",k)
    
	


ethusdt = bm.start_kline_socket("ETHUSDT", process_messageETH)
btcusdt = bm.start_kline_socket("BTCUSDT", process_messageBTC)


bm.start()
