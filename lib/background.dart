import 'dart:ui';

import 'package:flutter/material.dart';

import 'config.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment(-1.1, -0.8),
          child: Container(
            height: deviceSize.height * 0.1,
            width: deviceSize.width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              color: AppColors.backgroundYellow,
            ),
          ),
        ),
        Align(
          alignment: Alignment(1.2, 0.6),
          child: Container(
            height: deviceSize.height * 0.2,
            width: deviceSize.width * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80.0),
                color: AppColors.backgroundGreen),
          ),
        ),
        Align(
          alignment: Alignment(-1.2, 0.8),
          child: Container(
            height: deviceSize.height * 0.2,
            width: deviceSize.width * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80.0),
                color: AppColors.backgroundRed),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: child,
        ),
      ],
    );
  }
}
