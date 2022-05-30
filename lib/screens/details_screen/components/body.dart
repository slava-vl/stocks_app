import 'package:flutter/material.dart';

import '../../../models/company.dart';
import 'company_news_list.dart';
import 'header.dart';
import 'main_information_widget.dart';

class Body extends StatelessWidget {
  const Body(this.company, this.symbol);

  final Company company;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Header(company.name, company.logo),
          Expanded(
            child: PageView(
              children: [
                MainInformation(company),
                CompanyNews(symbol),
              ],
            ),
          )
        ],
      ),
    );
  }
}
