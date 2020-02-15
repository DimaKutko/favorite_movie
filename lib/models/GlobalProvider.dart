import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalProvider with ChangeNotifier {
  var _add;
  var _edit;
  String _token;
  Color dasboardColor,
      favoriteColor,
      searchColor,
      settingsColor,
      backgroundColor,
      textColor,
      buttonColor;

  bool _them, _recommendation;
  Color white = Colors.white;
  Color black = Colors.black;
  Color pink = Color.fromRGBO(236, 37, 65, 1);
  Color grey = Color.fromRGBO(127, 127, 145, 0.5);
  SystemUiOverlayStyle statusbar;

  get getThemColor => _them;

  set setThemColor(bool value) {
    _them = value;
    if (_them == false) {
      //dark
      statusbar = SystemUiOverlayStyle.light;
      backgroundColor = black;
      textColor = white;
      buttonColor = grey;
    } else if (_them == true) {
      //light
      statusbar = SystemUiOverlayStyle.dark;
      backgroundColor = white;
      textColor = black;
      buttonColor = black;
    }
    notifyListeners();
  }

  get getaddMovie => _add;

  set setaddMovie(var value) {
    _add = value;
    notifyListeners();
  }

  get recommendation => _recommendation;

  set recommendation(bool value) {
    _recommendation = value;
    notifyListeners();
  }

  get getToken => _token;

  set setToken(String value) {
    _token = value;
    notifyListeners();
  }

  get getEditMovie => _edit;

  set setEditMovie(var value) {
    _edit = value;
    notifyListeners();
  }

  dashboardSetColor() {
    dasboardColor = pink;
    favoriteColor = buttonColor;
    searchColor = buttonColor;
    settingsColor = buttonColor;
    notifyListeners();
  }

  favoriteSetColor() {
    dasboardColor = buttonColor;
    favoriteColor = pink;
    searchColor = buttonColor;
    settingsColor = buttonColor;
    notifyListeners();
  }

  searchSetColor() {
    dasboardColor = buttonColor;
    favoriteColor = buttonColor;
    searchColor = pink;
    settingsColor = buttonColor;
    notifyListeners();
  }

  settingsSetColor() {
    dasboardColor = buttonColor;
    favoriteColor = buttonColor;
    searchColor = buttonColor;
    settingsColor = pink;
    notifyListeners();
  }
}
