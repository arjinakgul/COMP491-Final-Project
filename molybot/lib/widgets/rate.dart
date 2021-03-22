import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Rate extends StatelessWidget {

  final int _coin;

  Rate(this._coin);

  final _ref = FirebaseDatabase.instance.reference().child("rates");
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
      .collection("rates")
      .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> tmp){
        if (tmp.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
        }
        final tmpDocs = tmp.data.docs;
        final test = tmpDocs[_coin];
        print(test.toString());
        return Text(
          
          test.data()["rate"].toString(),
          style: TextStyle(color:Colors.white),
        );
        
      });
  }
}