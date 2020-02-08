import 'package:favorite_movie/models/movie_info.dart';
import 'package:flutter/material.dart';

class CreateModel with ChangeNotifier {
  var add;

  CreateModel({addMovie}): add = addMovie;

  get addMovie => add;

  set addMovie(var value) {
    add = value;
    print(add.title);
    notifyListeners();
  }
}