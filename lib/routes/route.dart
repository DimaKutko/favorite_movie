import 'package:flutter/material.dart';
import 'package:favorite_movie/main.dart';
import 'package:favorite_movie/screens/favorite.dart';
import 'package:favorite_movie/screens/search.dart';
import 'package:favorite_movie/screens/account.dart';
import 'package:favorite_movie/screens/settings.dart';
import 'package:favorite_movie/screens/dashboard.dart';

final routes = {
  '/': (BuildContext context) => MyApp(),
  '/account': (BuildContext context) => Account(),
  '/favorite': (BuildContext context) => Favorite(),
  '/search': (BuildContext context) => Search(),
  '/settings': (BuildContext context) => Settings(),
  '/dashboard': (BuildContext context) => Dashboard(),
};

class NavigationBotom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            //кнопка панели
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.dashboard),
                color: Colors.yellow,
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
              ),
              Text(
                'Dashboard',
                style: TextStyle(color: Colors.yellow),
              ),
            ],
          ),
          Column(
            //кнопка акаунт
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.account_circle),
                color: Colors.yellow,
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, '/account');
                },
              ),
              Text(
                'Account',
                style: TextStyle(color: Colors.yellow),
              ),
            ],
          ),
          Column(
            //кнопка избранное
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.star),
                color: Colors.yellow,
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, '/favorite');
                },
              ),
              Text(
                'Favorite',
                style: TextStyle(color: Colors.yellow),
              ),
            ],
          ),
          Column(
            //кнопка поиск
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.yellow,
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
              Text(
                'Search',
                style: TextStyle(color: Colors.yellow),
              ),
            ],
          ),
          Column(
            //кнопка настройки
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                color: Colors.yellow,
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              Text(
                'Settings',
                style: TextStyle(color: Colors.yellow),
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
      color: Colors.grey[800],
    );
  }
}
