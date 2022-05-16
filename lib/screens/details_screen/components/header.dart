import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String name;
  final String logo;
  const Header(this.name, this.logo);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      height: 150,
      child: Stack(
        children: [
          Container(
            height: 75,
            color: _theme.primaryColor,
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
