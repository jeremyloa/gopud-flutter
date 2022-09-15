import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData lightTheme =
      ThemeData(primarySwatch: Colors.red, brightness: Brightness.light);

  ThemeData darkTheme =
      ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark);

  late ThemeData _selectedTheme;

  ThemeProvider({required bool isDark}) {
    _selectedTheme = isDark ? darkTheme : lightTheme;
  }

  void swapTheme() {
    _selectedTheme = _selectedTheme == darkTheme ? lightTheme : darkTheme;
    notifyListeners();
  }

  ThemeData get getTheme => _selectedTheme;
}
