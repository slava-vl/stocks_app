import 'package:volga_it_otbor/models/news.dart';

class MarketNewsModel extends News {
  final String category;
  final String related;

  MarketNewsModel({
    this.related,
    this.category,
    DateTime dateTime,
    String headline,
    int id,
    String image,
    String source,
    String summary,
    String url,
  }) : super(
          dateTime: dateTime,
          headline: headline,
          id: id,
          image: image,
          source: source,
          summary: summary,
          url: url,
        );
}
