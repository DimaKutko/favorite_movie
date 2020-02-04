import 'dart:ui';

import 'package:favorite_movie/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:favorite_movie/main.dart';
import 'package:favorite_movie/screens/favorite.dart';
import 'package:favorite_movie/screens/search.dart';
import 'package:favorite_movie/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';

final routes = {
  '/': (BuildContext context) => MyApp(),
  '/favorite': (BuildContext context) => Favorite(),
  '/search': (BuildContext context) => SearchF(),
  '/dashboard': (BuildContext context) => Dashboard(),
  '/login': (BuildContext context) => Login(),
};

class NavigationBotom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color pink = Color.fromRGBO(236, 37, 65, 1);

    return new ClipRect(
        child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: new Container(
                decoration: new BoxDecoration(
                    color: Color.fromRGBO(21, 21, 21, 1).withOpacity(0.5)),
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
                ))));
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
