import 'package:flutter/material.dart';

class PageViewIndicator extends StatelessWidget {
  PageController controller;
  int numberOfPages;
  int currentPage;

  PageViewIndicator({this.controller, this.numberOfPages, this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(numberOfPages, (index) {
          return GestureDetector(
              onTap: () {
                controller.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: currentPage == index
                          ? Color.fromARGB(255, 255, 111, 0)
                          : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10))));
        }));
  }
}
