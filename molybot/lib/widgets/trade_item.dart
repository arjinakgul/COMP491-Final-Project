import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/coin_screen.dart';
import '../models/trade.dart';
import 'package:provider/provider.dart';
import './rate.dart';
import '../providers/trades.dart';

class TradeItem extends StatefulWidget {
  @override
  _TradeItemState createState() => _TradeItemState();
}

class _TradeItemState extends State<TradeItem> {

  final uid = FirebaseAuth.instance.currentUser.uid;
  int btcAlarm, ethAlarm;

  @override
  void initState() {
    // TODO: implement initState    
    super.initState();
    _fetchData();
  }
   
  Future<void> _fetchData() async{
    final userData = await FirebaseFirestore.instance
    .collection("users").doc(uid).get();
    setState(() {
      btcAlarm = userData["btcAlarm"];
      ethAlarm = userData["ethAlarm"];
    
    });
  }

  void _toggleBTC(){
    if(btcAlarm==0) btcAlarm=1;
    else btcAlarm=0;
    FirebaseFirestore.instance
                .collection("users").doc(uid)
                .update({
                  "btcAlarm": btcAlarm
                });
  }
  void _toggleETH(){
    if(ethAlarm==0) ethAlarm=1;
    else ethAlarm=0;
    FirebaseFirestore.instance
                .collection("users").doc(uid)
                .update({
                  "ethAlarm": ethAlarm
                });
  }


  @override
  Widget build(BuildContext context) {
    setState(() {
      
    });
    final trades = Provider.of<Trades>(context);
    final trade = Provider.of<Trade>(context);
    final String _coinName = trade.coin.substring(0,3);
    int index = 0;
    _coinName == "BTC" ? index = 0 : index = 1;

    final alarm =
      index==0
      ? btcAlarm
      : ethAlarm;
    
    trades.setTradeAlarm(index, alarm);
    //trade.setAlarm(alarm);
    return Card(
        margin: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 8),
        color: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context).pushNamed(
            Coin.routeName,
            arguments: trade.coin);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12
          ),
          width: 300,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Icon(Icons.monetization_on_rounded, color: Colors.white,),
              Text(
                trade.coin, 
                style: TextStyle(color: Colors.white)),
              Rate(index),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                IconButton(
                  icon: Icon(
                      trade.isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    trade.favorite();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: trade.isFavorite
                          ? Text("${trade.coin} added to favorites.")
                          : Text("${trade.coin} removed from favorites."),
                      duration: Duration(milliseconds: 1200),
                    ));
                  },
                  color: trade.isFavorite ? Colors.red : Colors.white,
                ),
                IconButton(
                icon: Icon(
                  trade.isAlarm ? Icons.add_alert_rounded
                  : Icons.add_alert_outlined
                ), 
                onPressed: (){
                  trade.alarm();
                  index == 0
                ? _toggleBTC()
                : _toggleETH();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: 
                      trade.isAlarm ? Text("Alarm added for ${trade.coin}")
                      : Text("Alarm removed for ${trade.coin}."),
                      duration: Duration(milliseconds: 1200),));
                },
                color: 
                trade.isAlarm ? Colors.orange[300] : Colors.white,),
                ],
              ),
              
              
          ],        
          ),),
        ),
        );
  }
}