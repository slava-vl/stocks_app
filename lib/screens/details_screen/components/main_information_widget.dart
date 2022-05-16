import 'package:flutter/material.dart';

import '../../../models/company.dart';

class MainInformation extends StatelessWidget {
  final Company _company;

  const MainInformation(this._company, {Key key}) : super(key: key);

  Widget createTextInfo(String title, String value) {
    return Row(
      children: [
        Text(title),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(),
        )),
        Text(value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'Main Information',
          style: TextStyle(fontSize: 25),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: _theme.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5,
                  )
                ]),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                createTextInfo('Country', _company.country),
                createTextInfo('Currency', _company.currency),
                createTextInfo('Exchange', _company.exchange),
                createTextInfo('Finnhub Industry', _company.finnhubIndustry),
                createTextInfo('IPO', _company.ipo),
                createTextInfo('Market Capitalization',
                    _company.marketCapitalization.toString() + ' \$'),
                createTextInfo('Phone', _company.phone),
                createTextInfo(
                    'Share Outstanding', _company.shareOutstanding.toString()),
                createTextInfo('Weburl', _company.weburl),
              ],
            ),
          ),
        ),
      ],
    );
  }
}