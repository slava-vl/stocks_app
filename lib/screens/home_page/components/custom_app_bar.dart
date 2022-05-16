import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
              icon: Icon(Icons.settings_outlined),
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
                      Color.fromARGB(255, 255, 173, 59),
                      Color.fromARGB(255, 255, 47, 0)
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
                  icon: Icon(Icons.notifications_outlined),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 47, 0),
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
