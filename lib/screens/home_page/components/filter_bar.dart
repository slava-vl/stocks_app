import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/filter_bar_service.dart';
import '../../../config.dart';

class FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(standartPadding*2),
      child: Consumer<FilterBarService>(
        builder: (context, filterBarService, child) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  filterBarService.filterBarItems.length,
                  (index) {
                    return GestureDetector(
                      onTap: () => filterBarService.changeSelectedFilter(
                          filterBarService.filterBarItems[index]),
                      child: Container(
                        child: Text(
                          filterBarService.filterBarItems[index],
                          style: TextStyle(
                              color: filterBarService.filterBarItems[index] ==
                                      filterBarService.selectedFilter
                                  ? AppColors.orange
                                  : Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    alignment:
                        alignmentBasedOnTap(filterBarService.selectedFilter),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 111, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Alignment alignmentBasedOnTap(filterBarId) {
    switch (filterBarId) {
      case 'Most Popular':
        return Alignment.centerLeft;
      case 'Market News':
        return Alignment.centerRight;
      default:
        return Alignment.centerLeft;
    }
  }
}
