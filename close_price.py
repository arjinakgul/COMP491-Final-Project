import talib
import numpy
from binance.websockets import BinanceSocketManager
import pprint
import os.path, time





key = "rVmJxvysdYh7MFCeuuR6wGBvgGaYJrzwMKzyyoekbryxviYtKt1V9PatMj0w6AD7"
secret = "GRpWe4cX7vT4VfuitmZFH2pYvQKeRsegrMRBOEcYDoWp5ADSWO7G7ZC6HeAUVTEb"






from binance.client import Client
client = Client(key, secret)

info = client.get_exchange_info()

bm = BinanceSocketManager(client)


def process_messageETH(msg):
    now=round(float(time.time()))
    if os.path.isfile('closeprice.txt'):
        created=round(float(os.path.getctime("closeprice.txt")))
        if now-created>15:
            f = open("closeprice.txt", "r")
            lines = f.readlines()
            f.close()

            del lines[0]
        


            fn = open("closeprice.txt", "w+")
        

            for line in lines:
                fn.write(line)

            fn.close()

    #pprint.pprint(msg["k"]["c"])
    file1 = open("closeprice.txt","a")
    cl=msg["k"]["c"]
    file1.write(cl+"\n")
    file1.close()
    


    

#def process_messageBTC(msg):
 #   pprint.pprint(msg["k"]["c"])
	
    













#btcusdt = bm.start_kline_socket('BTCUSDT', process_messageBTC)
ethusdt = bm.start_kline_socket('ETHUSDT', process_messageETH)



bm.start()






