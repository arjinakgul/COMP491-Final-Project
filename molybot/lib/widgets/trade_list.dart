import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/trades.dart';
import './trade_item.dart';

class TradeList extends StatelessWidget {
  final int isFav;

  TradeList(this.isFav);

  @override
  Widget build(BuildContext context) {
    final trades = Provider.of<Trades>(context);
    final tradeList = trades.items;

    print(tradeList[0].isAlarm.toString());
    final favList = trades.favItems;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: isFav == 1 ? favList[i] : tradeList[i],
          child: TradeItem(),
        ),
        itemCount: isFav == 1 ? favList.length : tradeList.length,
      ),
    );
  }
}
