import 'package:flutter/cupertino.dart';

class FilterBarService with ChangeNotifier {
  List<String> filterBarItems = [
    'Most Popular',
    'Market News',
  ];

  String selectedFilter;

  void changeSelectedFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  FilterBarService() {
    selectedFilter = filterBarItems.first;
  }
}
