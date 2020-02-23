import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:favorite_movie/models/global_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color pink = Color.fromRGBO(236, 37, 65, 1);
  Color white = Color.fromRGBO(255, 255, 255, 1);

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushNamed(
      context,
      '/login',
    );
  }

  getToken() async {
    final provider = Provider.of<GlobalProvider>(context, listen: false);
    final data = await SharedPreferences.getInstance();
    final _token = data.getString('token') ?? null;
    final theme = data.getBool('theme') ?? false;
    final recommendetfavorite = data.getBool('recommendetfavorite') ?? false;
    final recommendation = data.getBool('recommendation') ?? true;
    provider.setToken = _token;
    provider.setThemColor = theme;
    provider.recommendation = recommendation;
    provider.recommendetfavorite = recommendetfavorite;
  }

  @override
  void initState() {
    super.initState();
    getToken();
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
