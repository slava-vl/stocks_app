import 'package:flutter/material.dart';

import '../../../api/api.dart';
import '../../../models/news.dart';
import 'news_card.dart';

class CompanyNews extends StatelessWidget {
  const CompanyNews(this.symbol, {Key key}) : super(key: key);

  final String symbol;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    final String toDate = '${date.year}-${date.month}-${date.day}';
    date = date.subtract(Duration(days: -7));
    final String fromDate = '${date.year}-${date.month}-${date.day}';
    return Column(
      children: [
        Text(
          'News',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        Expanded(
          child: FutureBuilder(
            future: Api.getCompanyNews(symbol, fromDate, toDate),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final news = snapshot.data as List<News>;
                return ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (ctx, index) => NewsCard(news[index]),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error', style: TextStyle(color: Colors.white),));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
