import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:molybot/widgets/graph.dart';

import 'package:provider/provider.dart';
import '../providers/trades.dart';

import '../widgets/coin_table.dart';
import './main_screen.dart';

class Coin extends StatefulWidget {
  static const routeName = "/coin";
  @override
  _CoinState createState() => _CoinState();
}

class _CoinState extends State<Coin> {
  final uid = FirebaseAuth.instance.currentUser.uid;
  int btcAlarm;
  int ethAlarm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final userData =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    setState(() {
      btcAlarm = userData["btcAlarm"];
      ethAlarm = userData["ethAlarm"];
    });
  }

  void _toggleBTC() {
    if (btcAlarm == 0)
      btcAlarm = 1;
    else
      btcAlarm = 0;
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"btcAlarm": btcAlarm});
  }

  void _toggleETH() {
    if (ethAlarm == 0)
      ethAlarm = 1;
    else
      ethAlarm = 0;
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"ethAlarm": ethAlarm});
  }

  Future<bool> _pop(BuildContext ctx, String route) {
    Navigator.of(ctx).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final trades = Provider.of<Trades>(context);

    final coinName = ModalRoute.of(context).settings.arguments;
    final trade = trades.findByCoin(coinName);
    final String _coinName = trade.coin.substring(0, 3);
    int index = 0;
    _coinName == "BTC" ? index = 0 : index = 1;
    final alarm = index == 0 ? btcAlarm : ethAlarm;
    trades.setTradeAlarm(index, alarm);

    return WillPopScope(
      onWillPop: () =>
          //Navigator.of(context).popAndPushNamed(MainScreen.routeName),
          _pop(context, MainScreen.routeName),
      child: Scaffold(
          backgroundColor: Color.fromRGBO(112, 112, 112, 0.15),
          appBar: AppBar(
            title: Text(trade.coin),
            elevation: 5,
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).popAndPushNamed(MainScreen.routeName),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/molybot_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.black87,
            actions: [
              IconButton(
                icon: Icon(
                    trade.isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  trade.favorite();
                  trades.refreshTradesList();
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
                icon: Icon(trade.isAlarm
                    ? Icons.add_alert_rounded
                    : Icons.add_alert_outlined),
                onPressed: () {
                  trade.alarm();
                  index == 0 ? _toggleBTC() : _toggleETH();

                  trades.refreshTradesList();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: trade.isAlarm
                        ? Text("Alarm added for ${trade.coin}")
                        : Text("Alarm removed for ${trade.coin}."),
                    duration: Duration(milliseconds: 1200),
                  ));
                },
                color: trade.isAlarm ? Colors.orange[300] : Colors.white,
              )
            ],
          ),
          body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("rates").snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> tmp) {
                if (tmp.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final tmpDocs = tmp.data.docs;
                final test = tmpDocs[index];
                final positive = test["change"] < 0 ? false : true;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(40),
                        child: Center(
                          child: Text(
                            test["rate"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        )),
                    Container(
                        child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: CoinTable(
                                positive,
                                test["change"].toString(),
                                test["weightedAvgPrice"].toString(),
                                test["highPrice"].toString(),
                                test["lowPrice"].toString(),
                                test[index == 0 ? "volumeBTC" : "volumeETH"]
                                    .toString(),
                                test["volumeUSDT"].toString(),
                                _coinName))),
                    Container(
                      width: 438,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: LineChartWidget(),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
