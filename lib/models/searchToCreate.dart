import 'package:flutter/material.dart';

class CreateModel with ChangeNotifier {
  var _add;

  CreateModel({addMovie}) : _add = addMovie;

  get getaddMovie => _add;

  set setaddMovie(var value) {
    _add = value;
    notifyListeners();
  }
}