import urllib.request
import json

data = {
        "Inputs": {
                "input1":
                [
                    {
                            'RATES': "2137.91",
                            'RSI': "50.62390594",
                            'ATR': "0.751923403",
                            'RATES_PRED': "2137.49",
                    }
                ],
        },
    "GlobalParameters":  {
    }
}

body = str.encode(json.dumps(data))

url = "YOUR API URL HERE"
api_key = "YOUR API KEY HERE"
headers = {'Content-Type':'application/json', 'Authorization':('Bearer '+ api_key)}

req = urllib.request.Request(url, body, headers)

try:
    response = urllib.request.urlopen(req)

    result = response.read().decode('utf-8')
    json_obj = json.loads(result)
    output = json_obj["Results"]["output1"][0]
    print(data)
    print(result)
    print(output)
except urllib.error.HTTPError as error:
    print("The request failed with status code: " + str(error.code))

    # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
    print(error.info())
    print(json.loads(error.read().decode("utf8", 'ignore')))