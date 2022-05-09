import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/company.dart';
import '../models/stock.dart';
import '../config.dart';

class StocksProvider with ChangeNotifier {
  List<Stock> prices = [
    Stock(name: "AAPL"),
    Stock(name: "AMZN"),
    Stock(name: "BINANCE:BTCUSDT"),
    Stock(name: "IC MARKETS:1"),
    Stock(name: "MSFT"),
  ];

  Future<bool> getData() async {
    prices.forEach((stock) async {
      final url = Uri.parse(
          'https://finnhub.io/api/v1/quote?symbol=${stock.name}&token=$APIKey');
      try {
        final response = await http.get(url);
        if (response.body != null) {
          stock.price = jsonDecode(response.body)['o'];
          notifyListeners();
        }
      } catch (err) {
        return false;
      }
    });

    return true;
  }

  void listenData() {
    final _channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.finnhub.io?token=$APIKey'),
    );

    onOpen(_channel);

    _channel.stream.listen(
      (data) {
        final resp = jsonDecode(data)['data'] as List<dynamic>;
        List<Stock> loadedData = [...prices];
        if (resp != null) {
          resp.forEach((element) {
            loadedData.firstWhere((el) => el.name == element['s']).lastPrice =
                double.parse(
              element['p'].toString(),
            );
          });
          prices = loadedData;
          notifyListeners();
        }
      },
      onError: (error) => print(error),
    );
  }

  void onOpen(WebSocketChannel channel) {
    //переписать
    channel.sink.add(jsonEncode({"type": "subscribe", "symbol": "AAPL"}));
    channel.sink.add(jsonEncode({"type": "subscribe", "symbol": "AMZN"}));
    channel.sink
        .add(jsonEncode({"type": "subscribe", "symbol": "BINANCE:BTCUSDT"}));
    channel.sink
        .add(jsonEncode({"type": "subscribe", "symbol": "IC MARKETS:1"}));
    channel.sink.add(jsonEncode({"type": "subscribe", "symbol": "MSFT"}));
  }
}
/*
Company Profile 2
Company News
IPO Calendar
Stock Candles

*/