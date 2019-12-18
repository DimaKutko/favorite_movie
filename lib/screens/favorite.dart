import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';


class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Top(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.grey[800],
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  "Favorite",
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
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
