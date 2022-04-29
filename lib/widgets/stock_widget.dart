import 'package:flutter/material.dart';

import '../config.dart';
import '../models/stock.dart';

class StockWidget extends StatelessWidget {
  final Stock stock;

  const StockWidget(this.stock);

  @override
  Widget build(BuildContext context) {
    final priceChange = stock.lastPrice != null && stock.price != null
        ? ((stock.lastPrice - stock.price) / stock.price * 100)
        : 0;
    return Padding(//слишком много padding-ов
      padding: const EdgeInsets.symmetric(
          horizontal: standartPadding * 0.8, vertical: standartPadding * 0.4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(standartPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stock.name,
                style: TextStyle(fontSize: 20),
              ),
              stock.price != null
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              priceChange.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 20,
                                color: priceChange >= 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            Icon(
                              priceChange >= 0
                                  ? Icons.arrow_circle_up
                                  : Icons.arrow_circle_down,
                              color:
                                  priceChange >= 0 ? Colors.green : Colors.red,
                            )
                          ],
                        ),
                        Text(stock.lastPrice != null
                            ? stock.lastPrice.toStringAsFixed(2)
                            : stock.price.toStringAsFixed(2))
                      ],
                    )
                  : const CircularProgressIndicator(strokeWidth: 2),
            ],
          ),
        ),
      ),
    );
  }
}
