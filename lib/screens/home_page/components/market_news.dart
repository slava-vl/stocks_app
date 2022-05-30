import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../config.dart';
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
            color: AppColors.orange,
          ),
        );
      return AnimatedList(
        initialItemCount: marketNewsService.marketNews.length,
        itemBuilder: (context, index,animation) {
          var currentNews = marketNewsService.marketNews[index];
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
            child: Container(
              margin: const EdgeInsets.all(standartPadding / 2),
              padding: const EdgeInsets.all(standartPadding),
              decoration: BoxDecoration(
                color: Colors.grey.shade900.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(standartPadding / 2),
                        decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          currentNews.category.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: Text(
                        currentNews.headline,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    currentNews.summary,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Image.network(currentNews.image),
                  SizedBox(height: 10),
                  Text(
                    DateFormat.yMMMMEEEEd().format(currentNews.dateTime),
                    style: TextStyle(
                      color: AppColors.orange,
                    ),
                  ),
                  Text(
                    'Source: ${currentNews.source}',
                    style: TextStyle(
                      color: AppColors.orange,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
