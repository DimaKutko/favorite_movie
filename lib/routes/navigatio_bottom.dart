import 'dart:ui';
import 'package:favorite_movie/models/global_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationBotom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(color: provider.backgroundColor),
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
                      enableFeedback: false,
                      icon: Icon(CupertinoIcons.news),
                      color: provider.dasboardColor,
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
                        color: provider.dasboardColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  //кнопка избранное
                  children: <Widget>[
                    IconButton(
                      icon: Icon(CupertinoIcons.heart),
                      color: provider.favoriteColor,
                      iconSize: 35,
                      onPressed: () {
                        Navigator.pushNamed(context, '/favorite');
                      },
                    ),
                    Text(
                      'Favorite',
                      style: TextStyle(
                        color: provider.favoriteColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  //кнопка поиск
                  children: <Widget>[
                    IconButton(
                      icon: Icon(CupertinoIcons.search),
                      color: provider.searchColor,
                      iconSize: 35,
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                    ),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: provider.searchColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  //кнопка поиск
                  children: <Widget>[
                    IconButton(
                      icon: Icon(CupertinoIcons.settings),
                      color: provider.settingsColor,
                      iconSize: 35,
                      onPressed: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: provider.settingsColor,
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
