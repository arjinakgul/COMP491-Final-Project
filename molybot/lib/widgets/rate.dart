import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rate extends StatelessWidget {
  final int _coin;
  double size;

  Rate(this._coin, this.size);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("rates").snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> tmp) {
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
            style: TextStyle(
              color: Colors.white,
              fontSize: size,
            ),
          );
        });
  }
}
