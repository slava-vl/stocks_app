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
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsScreen(widget.stock.name))),
      child: Container(
        color: Colors.grey.shade900.withOpacity(0.6),
        margin: const EdgeInsets.all(standartPadding),
        padding: const EdgeInsets.symmetric(
            vertical: standartPadding * 0.5, horizontal: standartPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                widget.stock.name,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: priceChange.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 20,
                          color: priceChange >= 0
                              ? priceChange > 0
                                  ? Colors.green
                                  : Colors.yellow
                              : Colors.red,
                        ),
                      ),
                      WidgetSpan(
                          child: Icon(
                        priceChange >= 0
                            ? Icons.arrow_circle_up
                            : Icons.arrow_circle_down,
                        color: priceChange >= 0
                            ? priceChange > 0
                                ? Colors.green
                                : Colors.yellow
                            : Colors.red,
                      ))
                    ],
                  ),
                ),
                Text(widget.stock.lastPrice != null
                    ? widget.stock.lastPrice.toStringAsFixed(2) + ' \$'
                    : widget.stock.price != null
                        ? widget.stock.price.toStringAsFixed(2) + ' \$'
                        : '0.0')
              ],
            )
          ],
        ),
      ),
    );
  }
}
