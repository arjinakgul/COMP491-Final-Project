import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/trades.dart';

import '../widgets/chart.dart';
class Coin extends StatefulWidget {

  static const routeName = "/coin";
  @override
  _CoinState createState() => _CoinState();
}

class _CoinState extends State<Coin> {

  

  @override
  Widget build(BuildContext context) {

    final trades = Provider.of<Trades>(context);

    final coinName = ModalRoute.of(context).settings.arguments;
    final trade = trades.findByCoin(coinName);
    return Scaffold(
      backgroundColor: Color.fromRGBO(112, 112, 112, 0.15),
      appBar: AppBar(
        title: Text(trade.coin),
        elevation: 5,
        leading: 
        Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipOval(
              child: Image.asset('assets/images/monopolyUncle.jpg', fit: BoxFit.cover,),
        ),
        ),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(
              trade.isFavorite ? Icons.favorite
              : Icons.favorite_border), 
            onPressed: (){
              trade.favorite();
              trades.refreshTradesList();
              ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: 
                      trade.isFavorite ? Text("${trade.coin} added to favorites.")
                      : Text("${trade.coin} removed from favorites."),
                      duration: Duration(milliseconds: 1200),));
            },
            color: trade.isFavorite ? Colors.red : Colors.white,),
          IconButton(
            icon: Icon(
              trade.isAlarm ? Icons.add_alert_rounded
              : Icons.add_alert_outlined), 
            onPressed: (){
              trade.alarm();
              trades.refreshTradesList();
              ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: 
                      trade.isAlarm ? Text("Alarm added for ${trade.coin}")
                      : Text("Alarm removed for ${trade.coin}."),
                      duration: Duration(milliseconds: 1200),));
              },
            color: 
                trade.isAlarm ? Colors.orange[300] : Colors.white,)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Chart(),
          )
        ),
        Container(child: Text("ORDER BOOKS", style: TextStyle(color: Colors.white)))
      ],)
      
    );
  }
}