from binance.websockets import BinanceSocketManager
import pprint
from firebase import firebase
import time
from binance.client import Client

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import requests




url="https://api.binance.com/api/v3/ticker/price"
paramETH={'symbol':'ETHUSDT'}


cred = credentials.Certificate("C:/Users/ardad/Desktop/molybot-650c9-firebase-adminsdk-vwmfr-e84aef6efc.json")
firebase_admin.initialize_app(cred, {
  'projectId': "molybot-650c9",
})

db = firestore.client()

doc_ref = db.collection(u'historical_data').document(u'ETH')
doc = doc_ref.get()

rates=[0.0]*144
dictdb=doc.to_dict()
for i in range(144):
    rates[i]=dictdb.get(str(i))
    #pass


while(True):
    r = requests.get(url = url, params = paramETH) 
    data = r.json()
    rate=data["price"]

    
    rates=rates[1:]
    rates.append(rate)
   
   
    
    

    
    
    rates=list(map(float,rates))

    doc_ref.set({
    
    u'0': rates[0],
    u'1': rates[1],
    u'2': rates[2],
    u'3': rates[3],
    u'4': rates[4],
    u'5': rates[5],
    u'6': rates[6],
    u'7': rates[7],
    u'8': rates[8],
    u'9': rates[9],
    u'10': rates[10],
    u'11': rates[11],
    u'12': rates[12],
    u'13': rates[13],
    u'14': rates[14],
    u'15': rates[15],
    u'16': rates[16],
    u'17': rates[17],
    u'18': rates[18],
    u'19': rates[19],
    u'20': rates[20],
    u'21': rates[21],
    u'22': rates[22],
    u'23': rates[23],
    u'24': rates[24],
    u'25': rates[25],
    u'26': rates[26],
    u'27': rates[27],
    u'28': rates[28],
    u'29': rates[29],
    u'30': rates[30],
    u'31': rates[31],
    u'32': rates[32],
    u'33': rates[33],
    u'34': rates[34],
    u'35': rates[35],
    u'36': rates[36],
    u'37': rates[37],
    u'38': rates[38],
    u'39': rates[39],
    u'40': rates[40],
    u'41': rates[41],
    u'42': rates[42],
    u'43': rates[43],
    u'44': rates[44],
    u'45': rates[45],
    u'46': rates[46],
    u'47': rates[47],
    u'48': rates[48],
    u'49': rates[49],
    u'50': rates[50],
    u'51': rates[51],
    u'52': rates[52],
    u'53': rates[53],
    u'54': rates[54],
    u'55': rates[55],
    u'56': rates[56],
    u'57': rates[57],
    u'58': rates[58],
    u'59': rates[59],
    u'60': rates[60],
    u'61': rates[61],
    u'62': rates[62],
    u'63': rates[63],
    u'64': rates[64],
    u'65': rates[65],
    u'66': rates[66],
    u'67': rates[67],
    u'68': rates[68],
    u'69': rates[69],
    u'70': rates[70],
    u'71': rates[71],
    u'72': rates[72],
    u'73': rates[73],
    u'74': rates[74],
    u'75': rates[75],
    u'76': rates[76],
    u'77': rates[77],
    u'78': rates[78],
    u'79': rates[79],
    u'80': rates[80],
    u'81': rates[81],
    u'82': rates[82],
    u'83': rates[83],
    u'84': rates[84],
    u'85': rates[85],
    u'86': rates[86],
    u'87': rates[87],
    u'88': rates[88],
    u'89': rates[89],
    u'90': rates[90],
    u'91': rates[91],
    u'92': rates[92],
    u'93': rates[93],
    u'94': rates[94],
    u'95': rates[95],
    u'96': rates[96],
    u'97': rates[97],
    u'98': rates[98],
    u'99': rates[99],
    u'100': rates[100],
    u'101': rates[101],
    u'102': rates[102],
    u'103': rates[103],
    u'104': rates[104],
    u'105': rates[105],
    u'106': rates[106],
    u'107': rates[107],
    u'108': rates[108],
    u'109': rates[109],
    u'110': rates[110],
    u'111': rates[111],
    u'112': rates[112],
    u'113': rates[113],
    u'114': rates[114],
    u'115': rates[115],
    u'116': rates[116],
    u'117': rates[117],
    u'118': rates[118],
    u'119': rates[119],
    u'120': rates[120],
    u'121': rates[121],
    u'122': rates[122],
    u'123': rates[123],
    u'124': rates[124],
    u'125': rates[125],
    u'126': rates[126],
    u'127': rates[127],
    u'128': rates[128],
    u'129': rates[129],
    u'130': rates[130],
    u'131': rates[131],
    u'132': rates[132],
    u'133': rates[133],
    u'134': rates[134],
    u'135': rates[135],
    u'136': rates[136],
    u'137': rates[137],
    u'138': rates[138],
    u'139': rates[139],
    u'140': rates[140],
    u'141': rates[141],
    u'142': rates[142],
    u'143': rates[143],
    u'max': max(rates),
    u'min': min(rates)
    


    
    })

    time.sleep(1)


    
