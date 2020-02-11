import 'package:favorite_movie/screens/%D1%81reate.dart';
import 'package:favorite_movie/screens/favorite.dart';
import 'package:favorite_movie/screens/search.dart';
import 'package:favorite_movie/screens/dashboard.dart';
import 'package:favorite_movie/screens/settings.dart';

final routes = {
  '/favorite': (context) => Favorite(),
  '/dashboard': (context) => Dashboard(),
  '/search': (context) => SearchF(),
  '/create': (context) => Create(),
  '/settings': (context) => Settings(), 
};
