

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/stock.dart';
import '../../../providers/stocks.dart';
import 'stock_list_item.dart';

class StockList extends StatefulWidget {
  final List<Stock> stocks;

  const StockList({Key key, this.stocks}) : super(key: key);
  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<Stock> insertedItems = [];

  @override
  void initState() {
    super.initState();

    Provider.of<StocksProvider>(context, listen: false).listenData();

    var future = Future(() {});
    for (var i = 0; i < widget.stocks.length; i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 125), () {
          insertedItems.add(widget.stocks[i]);
          _key.currentState.insertItem(i);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _key,
      scrollDirection: Axis.vertical,
      initialItemCount: insertedItems.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index, animation) {
        return SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.2),
              end: const Offset(0, 0),
            ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
                child: StockWidget(widget.stocks[index])));
      },
    );
  }
}
