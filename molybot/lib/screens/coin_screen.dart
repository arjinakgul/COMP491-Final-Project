import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:molybot/widgets/graph.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';

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
  final _fbm = FirebaseMessaging.instance;
  int btcAlarm;
  int ethAlarm;
  @override
  void initState() {
    // TODO: implement initState
    
    _fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      print(message);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
       print(message);
      return;
    });
    
    super.initState();
    _fetchData();
    //_notify();
    if(ethAlarm!=null && ethAlarm == 1)
      _fbm.subscribeToTopic("alarm");
  }

  Future<void> _fetchData() async {
    final userData =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    setState(() {
      btcAlarm = userData["btcAlarm"];
      ethAlarm = userData["ethAlarm"];
    });
  }

  // Future <void> _notify(){
  //   if(ethAlarm == 1)
  //     _fbm.subscribeToTopic('alarm');
  //   _fbm.unsubscribeFromTopic('alarm');
  // }

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
    if (ethAlarm == 0){
      _fbm.subscribeToTopic('alarm');
      ethAlarm = 1;
    }   
    else{
      _fbm.unsubscribeFromTopic('alarm');
      ethAlarm = 0;
    }
      
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
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: StreamBuilder(
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
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(32, 12, 8, 12),
                          child: Container(
                            padding: EdgeInsets.all(22),
                            decoration: BoxDecoration(
                            color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
                            height: 160,
                            child: Center(
                              child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Current Rate",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                        Text(test["rate"].toString(),
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 18)),
                        Text(
                          "Change",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                        Text(test["change"].toString()+"%",
                            style: TextStyle(
                              color: positive ? Colors.green : Colors.red[600], 
                              fontSize: 18)),
                      ],
                    ),),
                          ),
                        );
                      }
                    ),
                  ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: StreamBuilder(
                  stream: 
                  FirebaseFirestore.instance.collection("alarm")
                  .orderBy("time",descending: false).snapshots(),
                  builder: (ctx, AsyncSnapshot<QuerySnapshot> tmp) {
                      if (tmp.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                   }
                   final tmpDocs = tmp.data.docs;
                   final test = tmpDocs[tmpDocs.length-1];
                   final lastAlarm = test["time"];
                   final r = Timestamp.fromMillisecondsSinceEpoch(lastAlarm.toInt());
                   final q = DateTime.fromMillisecondsSinceEpoch(r.microsecondsSinceEpoch);
                   final hour = DateFormat.jm().format(q);
                   final date = DateFormat.MMMEd().format(q);
                   return Padding(
                     padding: const EdgeInsets.fromLTRB(
                       8, 12, 32, 12),
                     child: Container(
                       padding: EdgeInsets.all(22),
                       decoration: BoxDecoration(
                       color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
                       height: 160,
                       child: Center(child: 
                       Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                       [
                        Text(
                          "Last Alarm",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 6,),
                        Text(
                          index == 1 ?
                          hour.toString()
                          : "No recent alarms",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18)),
                        Text(
                          index == 1 ?
                          date.toString()
                          : "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18)),
                        SizedBox(height: 6,) 
                      ],)
                       )
                     ),
                   );
                  }),
                ),
                ],
              ),              
              StreamBuilder(
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
                    return Container(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 32
                            ),
                            child: CoinTable(
                                positive,
                                test["change"].toString(),
                                test["weightedAvgPrice"].toString(),
                                test["highPrice"].toString(),
                                test["lowPrice"].toString(),
                                test[index == 0 ? "volumeBTC" : "volumeETH"]
                                    .toString(),
                                test["volumeUSDT"].toString(),
                                _coinName)));
                  }),
                  Container(
                      width: 400,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 32
                        ),
                        child: LineChartWidget(),
                      ),
                    ),
            ],
          )
              ),
    );
  }
}
