import pymongo as pymongo
from binance.websockets import BinanceSocketManager

uri = "insert your db uri"
dbClient = pymongo.MongoClient(uri)

db = dbClient.rptutorials
ETHCollection = db.ETH
BTCCollection = db.BTC


key = "insert your binance API Key"
secret = "insert your binance secret key"

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
