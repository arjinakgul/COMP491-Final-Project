import 'package:flutter/material.dart';
import '../screens/coin_screen.dart';
import '../models/trade.dart';
import 'package:provider/provider.dart';

class TradeItem extends StatefulWidget {
  @override
  _TradeItemState createState() => _TradeItemState();
}

class _TradeItemState extends State<TradeItem> {
  @override
  Widget build(BuildContext context) {
    final trade = Provider.of<Trade>(context);
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
          width: 300,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.monetization_on_rounded, color: Colors.white,),
              Text(trade.coin, style: TextStyle(color: Colors.white)),
              IconButton(
                icon: Icon(
                  trade.isAlarm ? Icons.add_alert_rounded
                  : Icons.add_alert_outlined
                ), 
                onPressed: (){
                  trade.alarm();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: 
                      trade.isAlarm ? Text("Alarm added for ${trade.coin}")
                      : Text("Alarm removed for ${trade.coin}."),
                      duration: Duration(milliseconds: 1200),));
                },
                color: 
                trade.isAlarm ? Colors.orange[300] : Colors.white,),
              Text(trade.rate.toString(), style: TextStyle(color: Colors.white))
          ],        
          ),),
        ),
        );
  }
}