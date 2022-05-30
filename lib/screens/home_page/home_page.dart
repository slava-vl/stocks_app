import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:volga_it_otbor/providers/filter_bar_service.dart';
import 'package:volga_it_otbor/screens/home_page/components/filter_bar.dart';
import 'package:volga_it_otbor/screens/home_page/components/market_news.dart';
import 'package:volga_it_otbor/screens/home_page/components/stocks_pager.dart';

//import '../../providers/theme.dart';
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
  void initState() {
    Provider.of<StocksProvider>(context, listen: false).listenData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<StocksProvider>(context).prices;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Background(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              Padding(
                padding: const EdgeInsets.only(top: standartPadding*2, left: standartPadding*3, bottom: standartPadding),
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
                                ? ListView(
                                    physics: BouncingScrollPhysics(),
                                    children:
                                        _data.map((e) => StockWidget(e)).toList(),
                                  )
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
