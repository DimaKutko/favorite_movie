import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  var _add;
  Color dasboardColor, favoriteColor, searchColor, settingsColor;
  Color pink = Color.fromRGBO(236, 37, 65, 1);
  Color grey = Color.fromRGBO(123, 127, 145, 0.5);

  get getaddMovie => _add;

  set setaddMovie(var value) {
    _add = value;
    notifyListeners();
  }

   dashboardSetColor(){
    dasboardColor = pink;
    favoriteColor = grey;
    searchColor = grey;
    settingsColor = grey;
   notifyListeners(); 
  }

  favoriteSetColor(){
    dasboardColor = grey;
    favoriteColor = pink;
    searchColor = grey;
    settingsColor = grey;
   notifyListeners(); 
  }
  searchSetColor(){
    dasboardColor = grey;
    favoriteColor = grey;
    searchColor = pink;
    settingsColor = grey;
   notifyListeners(); 
  }
  settingsSetColor(){
    dasboardColor = grey;
    favoriteColor = grey;
    searchColor = grey;
    settingsColor = pink;
   notifyListeners(); 
  }
}