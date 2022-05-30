import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../apiKey.dart';
import '../models/market_news_model.dart';
import '../models/news.dart';
import '../models/company.dart';

class Api {
  static WebSocketChannel connectToStockSocket() {
    return WebSocketChannel.connect(
      Uri.parse('wss://ws.finnhub.io?token=$apiKey'),
    );
  }

  static Future<Company> getCompanyInformation(String symbol) async {
    final url = Uri.parse(
        'https://finnhub.io/api/v1/stock/profile2?symbol=$symbol&token=$apiKey');

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data.isEmpty) throw 'Error';
      return Company(
        country: data['country'],
        currency: data['currency'],
        exchange: data['exchange'],
        ipo: data['ipo'],
        marketCapitalization: data['marketCapitalization']*1.0,
        name: data['name'],
        phone: data['phone'],
        shareOutstanding: data['shareOutstanding']*1.0,
        ticker: data['ticker'],
        weburl: data['weburl'],
        logo: data['logo'],
        finnhubIndustry: data['finnhubIndustry'],
      );
    } catch (err) {
      print('Информация не получена: $err');
      rethrow;
    }
  }

  static Future<List<News>> getCompanyNews(
      String symbol, String from, String to) async {
    final url = Uri.parse(
        'https://finnhub.io/api/v1/company-news?symbol=$symbol&from=2022-04-01&to=2022-05-09&token=$apiKey');

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List<dynamic>;
      if (data.isEmpty) throw null;

      List<News> loadedData = [];
      for (var element in data) {
        loadedData.add(News(
          dateTime:
              DateTime.fromMillisecondsSinceEpoch(element['datetime'] * 1000),
          headline: element['headline'],
          id: element['id'],
          image: element['image'],
          source: element['source'],
          summary: element['summary'],
          url: element['url'],
        ));
      }

      return loadedData;
    } catch (err) {
      print('Информация не получена: $err');
      rethrow;
    }
  }

  static Future<List<MarketNewsModel>> getMarketNews() async {
    final url = Uri.parse(
        'https://finnhub.io/api/v1/news?category=general&token=$apiKey');

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List<dynamic>;
      if (data.isEmpty) throw null;

      List<MarketNewsModel> loadedData = [];
      for (var element in data) {
        loadedData.add(MarketNewsModel(
          category: element['category'],
          related: element['related'],
          dateTime:
              DateTime.fromMillisecondsSinceEpoch(element['datetime'] * 1000),
          headline: element['headline'],
          id: element['id'],
          image: element['image'],
          source: element['source'],
          summary: element['summary'],
          url: element['url'],
        ));
      }

      return loadedData;
    } catch (err) {
      print('Информация не получена: $err');
      rethrow;
    }
  }
}
