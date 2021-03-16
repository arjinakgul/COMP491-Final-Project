import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/main_screen.dart';
import './screens/coin_screen.dart';
import './providers/trades.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Trades())
      ],
      child: MaterialApp(
        title: 'Molybot',
        home: MainScreen(),
        routes: 
        {
          Coin.routeName: (ctx) => Coin(),
        },
      ) ,)
      ;
  }
}


