import 'package:flutter/cupertino.dart';

import '../api/api.dart';
import '../models/market_news_model.dart';

class MarketNewsService with ChangeNotifier {
  List<MarketNewsModel> marketNews;

  MarketNewsService() {
    Api.getMarketNews().then((value) {
      marketNews = value;
      notifyListeners();
    });
  }
}
