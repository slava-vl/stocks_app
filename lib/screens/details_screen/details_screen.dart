import 'package:flutter/material.dart';
import 'package:volga_it_otbor/background.dart';

import '../../api/api.dart';
import '../../config.dart';
import '../../models/company.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final String symbol;

  const DetailsScreen(this.symbol);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: Container(
          width: 48,
          height: 44,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade900.withOpacity(0.6),
          ),
          child: IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        title: Text(
          symbol,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.orange,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Background(
        child: FutureBuilder<Company>(
          future: Api.getCompanyInformation(symbol),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Body(snapshot.data, symbol);
            } else if (snapshot.hasError) {
              return Center(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: standartPadding * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Information was not received.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Please check your internet connection.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.orange,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    Icon(
                      Icons.wifi_off_outlined,
                      color: AppColors.orange,
                      size: 40,
                    )
                  ],
                ),
              ));
            }
            return LinearProgressIndicator(
              backgroundColor: AppColors.backgroundRed,
              color: AppColors.orange,
            );
          },
        ),
      ),
    );
  }
}
