import 'package:flutter/cupertino.dart';

import '../models/trade.dart';

class Trades with ChangeNotifier{

  List<Trade> _trades = [
    Trade("BTC/USDT", false, 0.1, false),
    Trade("ETH/USDT", false, 0.1, false),
  ];

  void setTradeAlarm(index, isAlarm){
    if(isAlarm==1)
    _trades[index].isAlarm=true;
    else _trades[index].isAlarm=false;
    notifyListeners();

  }

  List<Trade> get items {
    return _trades;
  }

  List<Trade> get favItems {
    
    
    return _trades.where((element) => element.isFavorite).toList();

  }

  Trade findByCoin(String coinName){
    return _trades.firstWhere((element) => element.coin == coinName);
  }

  void refreshTradesList() {
    notifyListeners();
  }
}

