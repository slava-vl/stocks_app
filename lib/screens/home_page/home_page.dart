import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:volga_it_otbor/models/stock.dart';
import 'package:volga_it_otbor/providers/filter_bar_service.dart';
import 'package:volga_it_otbor/screens/home_page/components/filter_bar.dart';
import 'package:volga_it_otbor/screens/home_page/components/market_news.dart';
import 'package:volga_it_otbor/screens/home_page/components/stocks_pager.dart';

import '../../background.dart';
import '../../config.dart';
import '../../providers/stocks.dart';
import 'components/custom_app_bar.dart';
import 'components/stock_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Background(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              Padding(
                padding: const EdgeInsets.only(
                    top: standartPadding * 2,
                    left: standartPadding * 3,
                    bottom: standartPadding),
                child: Text(
                  'Interesting',
                  style: TextStyle(
                    color: Colors.white54,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                  ),
                ),
              ),
              StocksPager(),
              const SizedBox(height: 10),
              Expanded(
                child: Column(
                  children: [
                    FilterBar(),
                    Expanded(
                      child: Consumer<FilterBarService>(
                        builder: (context, filterService, child) =>
                            filterService.selectedFilter == 'Most Popular'
                                ? StockList(stocks: Provider.of<StocksProvider>(context).prices,)
                                : MarketNews(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StockList extends StatefulWidget {
  final List<Stock> stocks;

  const StockList({Key key, this.stocks}) : super(key: key);
  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<Stock> insertedItems = [];

  @override
  void initState() {
    super.initState();

    Provider.of<StocksProvider>(context, listen: false).listenData();

    var future = Future(() {});
    for (var i = 0; i < widget.stocks.length; i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 125), () {
          insertedItems.add(widget.stocks[i]);
          _key.currentState.insertItem(i);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _key,
      scrollDirection: Axis.vertical,
      initialItemCount: insertedItems.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index, animation) {
        return SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.2),
              end: const Offset(0, 0),
            ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
                child: StockWidget(widget.stocks[index])));
      },
    );
  }
}
