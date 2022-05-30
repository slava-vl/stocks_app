import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config.dart';
import '../../../models/stock.dart';
import '../../../providers/stocks.dart';
import '../../details_screen/details_screen.dart';

class StockWidget extends StatefulWidget {
  final Stock stock;

  StockWidget(this.stock);

  @override
  State<StockWidget> createState() => _StockWidgetState();
}

class _StockWidgetState extends State<StockWidget> {
  var provider;
  @override
  void initState() {
    provider = Provider.of<StocksProvider>(context, listen: false);
    provider.listenStock(widget.stock.name);
    super.initState();
  }

  @override
  void dispose() {
    provider.notListenStock(widget.stock.name);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final priceChange =
        widget.stock.lastPrice != null && widget.stock.price != null
            ? ((widget.stock.lastPrice - widget.stock.price) /
                widget.stock.price *
                100)
            : 0;
    final changeColor = priceChange >= 0
        ? priceChange > 0
            ? AppColors.green
            : AppColors.orange
        : AppColors.red;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                changeColor.withOpacity(0.8),
                Colors.grey.shade900.withOpacity(0.3)
              ],
              stops: [
                0.1,
                0.3,
              ],
              begin: Alignment.topRight,
              end: Alignment.center,
            ),
          ),
          height: 100,
          margin: const EdgeInsets.all(standartPadding),
          padding: const EdgeInsets.symmetric(
            vertical: standartPadding * 0.5,
            horizontal: standartPadding,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: standartPadding, left: standartPadding),
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.stock.name,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    bottom: standartPadding, right: standartPadding),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: priceChange.toStringAsFixed(2) + '%',
                            style: TextStyle(
                              fontSize: 25,
                              color: changeColor,
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: standartPadding * 0.4,
                                  left: standartPadding * 0.4),
                              child: Image.asset(
                                priceChange >= 0
                                    ? 'assets/images/row_up.png'
                                    : 'assets/images/row_down.png',
                                width: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.stock.lastPrice != null
                          ? widget.stock.lastPrice.toStringAsFixed(2) + ' \$'
                          : widget.stock.price != null
                              ? widget.stock.price.toStringAsFixed(2) + ' \$'
                              : '0.0',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        InkWell(
          highlightColor: changeColor,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsScreen(widget.stock.name))),
          child: SizedBox(
            height: 100,
            width: double.infinity,
          ),
        )
      ],
    );
  }
}
