import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volga_it_otbor/models/company.dart';
import 'package:volga_it_otbor/models/stock.dart';
import 'package:volga_it_otbor/providers/stocks.dart';

class DetailsScreen extends StatelessWidget {
  final String symbol;

  const DetailsScreen(this.symbol);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(symbol),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: FutureBuilder(
        future: Provider.of<Stocks>(context, listen: false)
            .getCompanyInformation(symbol),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final company = snapshot.data as Company;
            return Body(company);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body(this.company);

  final Company company;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Header(company.name, company.logo),
          MainInformation(company)
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String name;
  final String logo;
  const Header(this.name, this.logo);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Stack(
        children: [
          Container(
            height: 75,
            color: Colors.grey[900],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                name,
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              height: 60,
              width: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(logo),
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey[900],
          ),
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
                  _company.marketCapitalization.toString()+' \$'),
              createTextInfo('Phone', _company.phone),
              createTextInfo(
                  'Share Outstanding', _company.shareOutstanding.toString()),
              createTextInfo('Weburl', _company.weburl),
            ],
          ),
        ),
        
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Main Information',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }
}
