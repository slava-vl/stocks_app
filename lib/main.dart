import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volga_it_otbor/providers/filter_bar_service.dart';
import 'package:volga_it_otbor/providers/market_news_service.dart';

import './providers/stocks.dart';
import './providers/theme.dart';
import 'screens/splach_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    theme.tryToGetTheme();
    theme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => StocksProvider()),
        ChangeNotifierProvider(create: (ctx) => CustomTheme()),
        ChangeNotifierProvider(create: (ctx) => FilterBarService()),
        ChangeNotifierProvider(create: (ctx) => MarketNewsService()),
      ],
      child: MaterialApp(
        themeMode: theme.currentTheme,
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        home: SplashScreen(),
      ),
    );
  }
}
