
import 'package:favorite_movie/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:favorite_movie/main.dart';
import 'package:favorite_movie/screens/favorite.dart';
import 'package:favorite_movie/screens/search.dart';
import 'package:favorite_movie/screens/settings.dart';
import 'package:favorite_movie/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';

final routes = {
  '/': (BuildContext context) => MyApp(),
  '/favorite': (BuildContext context) => Favorite(),
  '/search': (BuildContext context) => SearchF(),
  '/settings': (BuildContext context) => Settings(),
  '/dashboard': (BuildContext context) => Dashboard(),
  '/login': (BuildContext context) => Login(),
};

class NavigationBotom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            //кнопка панели
            children: <Widget>[
              IconButton(
                icon: Icon(CupertinoIcons.home),
                color: Color.fromRGBO(39, 58, 58, 1),
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/dashboard',
                  );
                },
              ),
              Text(
                'Dashboard',
                style: TextStyle(
                  color: Color.fromRGBO(39, 58, 58, 1),
                ),
              ),
            ],
          ),
          Column(
            //кнопка избранное
            children: <Widget>[
              IconButton(
                icon: Icon(CupertinoIcons.heart_solid),
                color: Color.fromRGBO(39, 58, 58, 1),
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, '/favorite');
                },
              ),
              Text(
                'Favorite',
                style: TextStyle(
                  color: Color.fromRGBO(39, 58, 58, 1),
                ),
              ),
            ],
          ),
          Column(
            //кнопка поиск
            children: <Widget>[
              IconButton(
                icon: Icon(CupertinoIcons.search),
                color: Color.fromRGBO(39, 58, 58, 1),
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
              Text(
                'Search',
                style: TextStyle(
                  color: Color.fromRGBO(39, 58, 58, 1),
                ),
              ),
            ],
          ),
          Column(
            //кнопка настройки
            children: <Widget>[
              IconButton(
                icon: Icon(CupertinoIcons.settings_solid),
                color: Color.fromRGBO(39, 58, 58, 1),
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              Text(
                'Settings',
                style: TextStyle(color: Color.fromRGBO(39, 58, 58, 1)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
    );
  }
}
