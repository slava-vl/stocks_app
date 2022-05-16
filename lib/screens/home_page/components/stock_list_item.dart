import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../models/stock.dart';
import '../../details_screen/details_screen.dart';

class StockWidget extends StatelessWidget {
  final Stock stock;

  const StockWidget(this.stock);

  @override
  Widget build(BuildContext context) {
    final priceChange = stock.lastPrice != null && stock.price != null
        ? ((stock.lastPrice - stock.price) / stock.price * 100)
        : 0;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailsScreen(stock.name))),
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
                stock.name,
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
                Text(stock.lastPrice != null
                    ? stock.lastPrice.toStringAsFixed(2) + ' \$'
                    : stock.price != null
                        ? stock.price.toStringAsFixed(2) + ' \$'
                        : '0.0')
              ],
            )
          ],
        ),
      ),
    );
  }
}
