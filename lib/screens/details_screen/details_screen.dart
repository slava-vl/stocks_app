import 'package:flutter/material.dart';

import '../../api/api.dart';
import '../../models/company.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final String symbol;

  const DetailsScreen(this.symbol);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(symbol),
        backgroundColor: _theme.primaryColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: Api.getCompanyInformation(symbol),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final company = snapshot.data as Company;
            return Body(company, symbol);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
