import 'package:flutter/material.dart';
import 'package:molybot/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/main_screen.dart';
import './screens/coin_screen.dart';
import './providers/trades.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider.value(value: Trades())
    //   ],
    //   child: MaterialApp(
    //     title: 'Molybot',
    // routes:
    // {
    //   Coin.routeName: (ctx) => Coin(),
    // },
    //     home: MainScreen(),

    //   ) ,);
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
          return MultiProvider(
            providers: [ChangeNotifierProvider.value(value: Trades())],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: {
                Coin.routeName: (ctx) => Coin(),
                MainScreen.routeName: (ctx) => MainScreen()
              },
              title: 'Molybot',
              home: appSnapshot.connectionState != ConnectionState.done
                  ? Center(child: CircularProgressIndicator())
                  : StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (ctx, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            value: 12,
                          ));
                        }
                        if (userSnapshot.hasData) {
                          return MainScreen();
                        }
                        return ProfileScreen();
                      }),
            ),
          );
        });
  }
}
