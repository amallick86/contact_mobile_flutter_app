import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

//light mode
ThemeData light = ThemeData(
  primaryColor: Colors.indigoAccent,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey[200],
  accentColor: Colors.blue,
  fontFamily: 'Georgia',
  textTheme: TextTheme(
    bodyText2: TextStyle(fontFamily: "Hind", fontWeight: FontWeight.bold),
    bodyText1: TextStyle(
      fontFamily: "Hind",
      fontSize: 30.0,
      fontWeight: FontWeight.w400,
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  buttonColor: Colors.white,
  cardColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(
      color: Colors.indigoAccent,
    ),
    selectedLabelStyle: TextStyle(
      fontFamily: "Hind",
      fontWeight: FontWeight.bold,
      color: Colors.indigoAccent,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.black54,
    ),
    border: OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.pink,
    )),
  ),
);
//dark mode
ThemeData dark = ThemeData(
  primaryColor: Colors.grey[800],
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[850],
  accentColor: Colors.indigoAccent,
  fontFamily: 'Georgia',
  textTheme: TextTheme(
    bodyText2: TextStyle(
        fontFamily: "Hind", fontWeight: FontWeight.bold, color: Colors.white),
    bodyText1: TextStyle(
      fontFamily: "Hind",
      fontSize: 30.0,
      fontWeight: FontWeight.w400,
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  buttonColor: Colors.red[200],
  cardColor: Colors.grey[700],
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[500],
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(color: Colors.white),
      selectedLabelStyle: TextStyle(
        fontFamily: "Hind",
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.pink,
      ),
    ),
  ),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }
  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}
