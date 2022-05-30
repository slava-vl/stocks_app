import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../api/api.dart';
import '../apiKey.dart';
import '../models/stock.dart';

class StocksProvider with ChangeNotifier {
  WebSocketChannel _channel;
  List<Stock> prices = [
    Stock(name: "AAPL"),
    Stock(name: "AMZN"),
    Stock(name: "MSFT"),
    Stock(name: "GOOGL"),
    Stock(name: "TSLA"),
    Stock(name: "FB"),
    Stock(name: "NVDA"),
    Stock(name: "V"),
    Stock(name: "DIS"),
    Stock(name: "NKE"),
    Stock(name: "INTC"),
    Stock(name: "TM"),
    Stock(name: "KO"),
    Stock(name: "PEP"),
    Stock(name: "BABA"),
    Stock(name: "WMT"),
    Stock(name: "MA"),
    Stock(name: "XOM")
  ];

  Future<bool> getData() async {
    prices.forEach((stock) async {
      final url = Uri.parse(
          'https://finnhub.io/api/v1/quote?symbol=${stock.name}&token=$APIKey');
      try {
        final response = await http.get(url);
        if (response.body != null) {
          stock.lastPrice = jsonDecode(response.body)['c'] * 1.0;
          stock.price = jsonDecode(response.body)['o'] * 1.0;
          notifyListeners();
        }
      } catch (err) {
        print(err);
        return false;
      }
    });

    return true;
  }

  List<Stock> get interesting => prices
      .where((element) =>
          element.name == 'AMZN' ||
          element.name == 'MSFT' ||
          element.name == 'AAPL')
      .toList();

  void listenData() {
    _channel = Api.connectToStockSocket();

    _channel.stream.listen(
      (data) {
        final resp = jsonDecode(data)['data'] as List<dynamic>;
        List<Stock> loadedData = [...prices];
        if (resp != null) {
          resp.forEach((element) {
            loadedData.firstWhere((el) => el.name == element['s']).lastPrice =
                element['p'] * 1.0;
          });
          prices = loadedData;
          notifyListeners();
        }
      },
      onError: (error) => print(error),
    );
  }

  void listenStock(String symbol) {
    _channel.sink.add(jsonEncode({"type": "subscribe", "symbol": symbol}));
  }

  void notListenStock(String symbol) {
    _channel.sink.add(jsonEncode({"type": "unsubscribe", "symbol": symbol}));
  }
}