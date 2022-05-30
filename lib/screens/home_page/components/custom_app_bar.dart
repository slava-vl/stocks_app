import 'package:flutter/material.dart';

import '../../../config.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: standartPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 48,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade900.withOpacity(0.6),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings_outlined, color: Colors.white),
            ),
          ),
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      AppColors.orange,
                      AppColors.red,
                    ])),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.black,
              ),
              margin: const EdgeInsets.all(2.0),
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                  radius: 20),
            ),
          ),
          Stack(
            children: [
              Container(
                width: 48,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade900.withOpacity(0.6),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: AppColors.red,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
