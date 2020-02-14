import 'package:favorite_movie/screens/%D1%81reate.dart';
import 'package:favorite_movie/screens/edit.dart';
import 'package:favorite_movie/screens/favorite.dart';
import 'package:favorite_movie/screens/login.dart';
import 'package:favorite_movie/screens/search.dart';
import 'package:favorite_movie/screens/dashboard.dart';
import 'package:favorite_movie/screens/settings.dart';
import 'package:favorite_movie/screens/splash.dart';

final routes = {
  '/splash': (context) => SplashScreen(),
  '/login': (context) => Login(),
  '/favorite': (context) => Favorite(),
  '/dashboard': (context) => Dashboard(),
  '/search': (context) => SearchF(),
  '/create': (context) => Create(),
  '/settings': (context) => Settings(),
  '/edit': (context) => Edit(),
};
