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
    final tradeList = 
    isFav== 0 ? trades.items 
    : trades.favItems;
    
    //final favList = trades.favItems;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
          itemBuilder: (ctx, i)=>ChangeNotifierProvider.value(
            value: tradeList[i],
            child: TradeItem(),),
          itemCount: tradeList.length,),
    );
  }
}