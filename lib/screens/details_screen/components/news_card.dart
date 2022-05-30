import 'package:flutter/material.dart';

import '../../../models/news.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(this.news, {Key key}) : super(key: key);
  final News news;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
          )
        ],
        color: _theme.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            news.headline,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          if (news.image.isNotEmpty)
            Image.network(
              news.image,
              errorBuilder: (context, error, stackTrace) => Image.network(
                  'https://pro2-bar-s3-cdn-cf1.myportfolio.com/595e16db507530aedc596bfea5b9b205/c4942518-4c81-4440-b5e6-a81ee775fccd_car_202x158.gif?h=7f6473aa96778a9138ad4bbdbcdf698d'),
            ),
          SizedBox(height: 10),
          Text(news.summary),
          SizedBox(height: 10),
          Text(
            'Source: ${news.source}',
            textAlign: TextAlign.right,
            style: TextStyle(color: _theme.textTheme.subtitle1.color.withOpacity(0.5)),
          ),
          Text(
            'Date: ${news.dateTime.day}.${news.dateTime.month}.${news.dateTime.year}',
            style: TextStyle(color: _theme.textTheme.subtitle1.color.withOpacity(0.5)),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.translate))
        ],
      ),
    );
  }
}
