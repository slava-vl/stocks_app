import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../providers/theme.dart';
import '../../providers/stocks.dart';
import 'components/stock_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<StocksProvider>(context, listen: false).listenData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<StocksProvider>(context).prices;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Stocks',
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  theme.toggleTheme();
                });
              },
              icon: Icon(Icons.wb_sunny_rounded),
            )
          ]),
      body: ListView(
        children: [..._data.map((e) => StockWidget(e)).toList()],
      ),
    );
  }
}
