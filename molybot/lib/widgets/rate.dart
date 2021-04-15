import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rate extends StatelessWidget {

  final int _coin;

  Rate(this._coin);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
      .collection("rates")
      .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> tmp){
        if (tmp.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("None"),
                );
        }
        final tmpDocs = tmp.data.docs;
        final test = tmpDocs[_coin];
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              //height: 8,
            ),
            Text(
              test.data()["rate"].toString(),
              style: TextStyle(
                color:Colors.white,
                fontSize: 14),
            ),
            SizedBox(
              height: 7.5
            ),
            Text(
              "${test.data()["change"].toString()}%",
              style: TextStyle(
                color: 
                test.data()["change"]<0 
                ? Colors.red[600]
                : Colors.green,
                fontSize: 12
              ),
            ),
            SizedBox(
              height: 8
            ),
          ],
        );
        
      });
  }
}