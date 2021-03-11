import pymongo as pymongo
from binance.websockets import BinanceSocketManager

uri = "mongodb://orderbook:sZgAPKXIjMEBKNtkuv4vI6a4qANNUOzDrzshHHElU2P2aSsdjKMuvznALhRzmCR1TbFus7ISuBBoky9mfPO5JQ==@orderbook.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@orderbook@"
dbClient = pymongo.MongoClient(uri)

db = dbClient.rptutorials
ETHCollection = db.ETH
BTCCollection = db.BTC


key = "rVmJxvysdYh7MFCeuuR6wGBvgGaYJrzwMKzyyoekbryxviYtKt1V9PatMj0w6AD7"
secret = "GRpWe4cX7vT4VfuitmZFH2pYvQKeRsegrMRBOEcYDoWp5ADSWO7G7ZC6HeAUVTEb"

from binance.client import Client
client = Client(key, secret)

info = client.get_exchange_info()

bm = BinanceSocketManager(client)

def process_messageETH(msg):
	msg.pop("U")
	msg.pop("u")
	msg.pop("e")
	msg.pop("s")
	ETHCollection.insert_one(msg)


def process_messageBTC(msg):
	msg.pop("U")
	msg.pop("u")
	msg.pop("e")
	msg.pop("s")
	BTCCollection.insert_one(msg)


ethusdt = bm.start_depth_socket("ETHUSDT", process_messageETH,interval=100)


bm.start()
