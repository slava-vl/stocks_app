import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String name;
  final String logo;
  const Header(this.name, this.logo);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                name,
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 15),
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 60,
            width: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                logo,
                errorBuilder: (context, error, stackTrace) => Image.network(
                    'https://pro2-bar-s3-cdn-cf1.myportfolio.com/595e16db507530aedc596bfea5b9b205/c4942518-4c81-4440-b5e6-a81ee775fccd_car_202x158.gif?h=7f6473aa96778a9138ad4bbdbcdf698d'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
