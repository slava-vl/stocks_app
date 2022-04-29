import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/theme.dart';
import '../providers/stocks.dart';
import '../widgets/stock_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Stocks>(context, listen: false).getData().then(
          (value) => Provider.of<Stocks>(context, listen: false).listenData());
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<Stocks>(context).prices;
    return Scaffold(
      appBar: AppBar(
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
