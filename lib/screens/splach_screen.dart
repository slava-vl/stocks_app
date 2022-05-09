import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volga_it_otbor/screens/home_page.dart';

import '../providers/stocks.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.wait([
      Future.delayed(Duration(seconds: 2)),
      Provider.of<StocksProvider>(context, listen: false).getData(),
    ]).then((value) => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage())));

    return Stack(
      children: [
        Container(color: Color.fromARGB(255, 48, 48, 48)),
        const Align(
          alignment: Alignment.center,
          child: Icon(Icons.monetization_on_outlined, color: Colors.yellow, size: 80),

        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 90,
            height: 90,
            child: CircularProgressIndicator(
              color: Colors.yellow.withOpacity(0.2),
              strokeWidth: 5,
            ),
          ),
        )
      ],
    );
  }
}
