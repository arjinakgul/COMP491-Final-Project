

import 'package:flutter/cupertino.dart';

class Trade with ChangeNotifier{

  final String coin;
  bool isAlarm=false;
  final double rate;
  bool isFavorite=false;
  Trade(this.coin, this.isAlarm, this.rate, this.isFavorite);

  void alarm(){
    isAlarm = !isAlarm;
    notifyListeners();
  }

  void setAlarm(int alarm){
    this.isAlarm = 
      alarm == 1
      ? true
      : false;
    notifyListeners();
  }

  void favorite(){
    isFavorite = !isFavorite;
    notifyListeners();
  }
}