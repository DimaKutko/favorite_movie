import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 78, 78, 1),
      body: Column(
        children: <Widget>[
          Top(),
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  'Window settings',
                  style: TextStyle(color: Colors.yellow),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: NavigationBotom(),
          ),
        ],
      ),
    );
  }
}
