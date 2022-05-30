import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volga_it_otbor/providers/filter_bar_service.dart';
import 'package:volga_it_otbor/providers/market_news_service.dart';

import './providers/stocks.dart';
import 'screens/splach_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => StocksProvider()),
        ChangeNotifierProvider(create: (ctx) => FilterBarService()),
        ChangeNotifierProvider(create: (ctx) => MarketNewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
