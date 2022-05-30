import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/stock.dart';
import '../../../config.dart';
import '../../../providers/stocks.dart';
import 'page_view_indicator.dart';

class StocksPager extends StatefulWidget {
  const StocksPager({Key key}) : super(key: key);

  @override
  State<StocksPager> createState() => _StocksPagerState();
}

class _StocksPagerState extends State<StocksPager> {
  List<Stock> pages;

  int currentPage = 0;
  PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: 0);

    pages = Provider.of<StocksProvider>(context, listen: false).interesting;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Column(
        children: [
          Expanded(
            child: PageView(
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                controller: controller,
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                children: List.generate(3, (index) {
                  Stock currentStock = pages[index];
                  return Column(
                    children: [
                      Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Image.asset('assets/images/BG.png'),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(standartPadding*2),
                                  child: Row(
                                    children: [
                                      Text(
                                        currentStock.name,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: standartPadding, vertical: standartPadding/2),
                                        decoration: BoxDecoration(
                                            color: currentStock.lastPrice !=
                                                        null &&
                                                    currentStock.price !=
                                                        null &&
                                                    currentStock.lastPrice >
                                                        currentStock.price
                                                ? AppColors.green
                                                : AppColors.red,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          currentStock.lastPrice != null
                                              ? '\$' +
                                                  currentStock.lastPrice
                                                      .toStringAsFixed(2)
                                              : '\$' +
                                                  currentStock.price
                                                      .toStringAsFixed(2),
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  );
                })),
          ),
          PageViewIndicator(
            controller: controller,
            numberOfPages: pages.length,
            currentPage: currentPage,
          ),
        ],
      ),
    );
  }
}
