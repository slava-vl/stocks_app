import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volga_it_otbor/background.dart';
import 'package:volga_it_otbor/screens/home_page/home_page.dart';

import '../../config.dart';
import '../../providers/stocks.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) => Future.wait([
          Provider.of<StocksProvider>(context, listen: false).getData(),
        ]).then((value) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()))));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Background(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/emblem.png',
                width: 80,
              ),
            ),
            SizedBox(
              child: LinearProgressIndicator(
                color: AppColors.orange,
                backgroundColor: AppColors.backgroundRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
