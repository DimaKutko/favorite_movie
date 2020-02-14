import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color pink = Color.fromRGBO(236, 37, 65, 1);
  Color white = Color.fromRGBO(255, 255, 255, 1);

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushNamed(
      context,
      '/login',
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/LogoFM.png',
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Favorie ',
                  style: TextStyle(
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: pink,
                  ),
                ),
                Text(
                  'Movie',
                  style: TextStyle(
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 170,
            ),
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(white)),
          ],
        ));
  }
}
