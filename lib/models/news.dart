import 'package:flutter/material.dart';

class News {
  final DateTime dateTime;
  final String headline;
  final int id;
  final String image;
  final String source;
  final String summary;
  final String url;

  News({
    @required this.dateTime,
    @required this.headline,
    @required this.id,
    @required this.image,
    @required this.source,
    @required this.summary,
    @required this.url,
  });
}
