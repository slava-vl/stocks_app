import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volga_it_otbor/models/company.dart';
import 'package:volga_it_otbor/models/news.dart';

import '../providers/company.dart';

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
        future: Provider.of<CompanyProvider>(context, listen: false)
            .getCompanyInformation(symbol),
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
                  _company.marketCapitalization.toString() + ' \$'),
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

class CompanyNews extends StatelessWidget {
  const CompanyNews(this.symbol, {Key key}) : super(key: key);

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'News',
          style: TextStyle(fontSize: 25),
        ),
        Expanded(
          child: FutureBuilder(
            future: Provider.of<CompanyProvider>(context, listen: false)
                .getCompanyNews(symbol),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final news = snapshot.data as List<News>;
                return ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (ctx, index) => NewsCard(news[index]),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error'));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard(this.news, {Key key}) : super(key: key);
  final News news;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
          )
        ],
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            news.headline,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          if (news.image.isNotEmpty)
            Image.network(
              news.image,
              errorBuilder: (context, error, stackTrace) => Image.network(
                  'https://pro2-bar-s3-cdn-cf1.myportfolio.com/595e16db507530aedc596bfea5b9b205/c4942518-4c81-4440-b5e6-a81ee775fccd_car_202x158.gif?h=7f6473aa96778a9138ad4bbdbcdf698d'),
            ),
          SizedBox(height: 10),
          Text(news.summary),
          Text(
            'Source: ${news.source}',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white.withOpacity(0.5)),
          )
        ],
      ),
    );
  }
}
