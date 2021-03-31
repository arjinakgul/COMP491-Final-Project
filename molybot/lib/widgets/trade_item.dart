import 'package:flutter/material.dart';
import '../screens/coin_screen.dart';
import '../models/trade.dart';
import 'package:provider/provider.dart';
import './rate.dart';

class TradeItem extends StatefulWidget {
  @override
  _TradeItemState createState() => _TradeItemState();
}

class _TradeItemState extends State<TradeItem> {
  @override
  Widget build(BuildContext context) {
    final trade = Provider.of<Trade>(context);
    final String _coinName = trade.coin.substring(0, 3);
    int index = 0;
    _coinName == "BTC" ? index = 0 : index = 1;
    //final String rate = Rate(_coinName).toString();
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      color: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context)
              .pushNamed(Coin.routeName, arguments: trade.coin);
        },
        child: Container(
          width: 300,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.monetization_on_rounded,
                color: Colors.white,
              ),
              Text(trade.coin, style: TextStyle(color: Colors.white)),
              IconButton(
                icon: Icon(trade.isAlarm
                    ? Icons.add_alert_rounded
                    : Icons.add_alert_outlined),
                onPressed: () {
                  trade.alarm();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: trade.isAlarm
                        ? Text("Alarm added for ${trade.coin}")
                        : Text("Alarm removed for ${trade.coin}."),
                    duration: Duration(milliseconds: 1200),
                  ));
                },
                color: trade.isAlarm ? Colors.orange[300] : Colors.white,
              ),
              Rate(index, 16)
            ],
          ),
        ),
      ),
    );
  }
}
