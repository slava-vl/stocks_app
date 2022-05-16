import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/market_news_service.dart';

class MarketNews extends StatefulWidget {
  const MarketNews({Key key}) : super(key: key);

  @override
  State<MarketNews> createState() => _MarketNewsState();
}

class _MarketNewsState extends State<MarketNews> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketNewsService>(
        builder: (context, marketNewsService, child) {
      if (marketNewsService.marketNews == null)
        return Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 255, 111, 0),
          ),
        );
      return ListView.builder(
        itemCount: marketNewsService.marketNews.length,
        itemBuilder: (context, index) {
          var currentNews = marketNewsService.marketNews[index];
          return Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration:
                BoxDecoration(color: Colors.grey.shade900.withOpacity(0.6)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 111, 0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        currentNews.category.toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(
                      currentNews.headline,
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w900),
                    )),
                  ],
                ),
                SizedBox(height: 10),
                Text(currentNews.summary),
                SizedBox(height: 10),
                Image.network(currentNews.image),
                SizedBox(height: 10),
                Text(
                  currentNews.dateTime.toString(),
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 111, 0),
                  ),
                ),
                Text(
                  'Source: ${currentNews.source}',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 111, 0),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
