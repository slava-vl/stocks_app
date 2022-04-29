import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

CustomTheme theme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', _isDarkTheme.toString());
  }

  Map<String, bool> _stringToBool = const {'true': true, 'false': false};

  Future<void> tryToGetTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('theme')) {
      return;
    }
    _isDarkTheme = _stringToBool[prefs.getString('theme')];
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, foregroundColor: Colors.black),
      primaryColor: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark();
  }
}
