import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:volga_it_otbor/api/api.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/stock.dart';
import '../config.dart';

class StocksProvider with ChangeNotifier {
  List<Stock> prices = [
    Stock(name: "AAPL"),
    Stock(name: "AMZN"),
    Stock(name: "MSFT"),
    Stock(name: "GOOGL"),
    Stock(name: "TSLA"),
    Stock(name: "FB"),
    Stock(name: "NVDA"),
    Stock(name: "V"),
    Stock(name: "KO"),
  ];

  Future<bool> getData() async {
    prices.forEach((stock) async {
      final url = Uri.parse(
          'https://finnhub.io/api/v1/quote?symbol=${stock.name}&token=$APIKey');
      try {
        final response = await http.get(url);
        if (response.body != null) {
          stock.price = jsonDecode(response.body)['o']*1.0;
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
    final _channel = Api.connectToStockSocket();

    onOpen(_channel);

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

  void onOpen(WebSocketChannel channel) {
    prices.forEach((element) {
      channel.sink.add(jsonEncode({"type": "subscribe", "symbol": element.name}));
    });
  }
}
/*
Company Profile 2
Company News
IPO Calendar
Stock Candles
*/