import 'dart:ui';
import 'package:favorite_movie/screens/%D1%81reate.dart';
import 'package:flutter/material.dart';
import 'package:favorite_movie/main.dart';
import 'package:favorite_movie/screens/favorite.dart';
import 'package:favorite_movie/screens/search.dart';
import 'package:favorite_movie/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';

final routes = {
  '/favorite': (context) => Favorite(),
  '/dashboard': (context) => Dashboard(),
  '/search': (context) => SearchF(),
  '/create': (context) => Create(),
};

class NavigationBotom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color pink = Color.fromRGBO(236, 37, 65, 1);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(21, 21, 21, 0.2).withOpacity(0.3)),
          child: Container(
            height: 70,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  //кнопка панели
                  children: <Widget>[
                    IconButton(
                      icon: Icon(CupertinoIcons.news),
                      color: pink,
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
                        color: pink,
                      ),
                    ),
                  ],
                ),
                Column(
                  //кнопка избранное
                  children: <Widget>[
                    IconButton(
                      icon: Icon(CupertinoIcons.heart_solid),
                      color: pink,
                      iconSize: 35,
                      onPressed: () {
                        Navigator.pushNamed(context, '/favorite');
                      },
                    ),
                    Text(
                      'Favorite',
                      style: TextStyle(
                        color: pink,
                      ),
                    ),
                  ],
                ),
                Column(
                  //кнопка поиск
                  children: <Widget>[
                    IconButton(
                      icon: Icon(CupertinoIcons.search),
                      color: pink,
                      iconSize: 35,
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                    ),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: pink,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
