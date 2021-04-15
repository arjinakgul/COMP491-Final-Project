import talib
import numpy as np
import os.path, time


f = open("closeprice.txt", "r")
text=list(map(float,f.read().split("\n")[:-1]))

arr=np.array(text)
print(arr)
 

output= talib.RSI(arr, timeperiod=15)


print(output)


