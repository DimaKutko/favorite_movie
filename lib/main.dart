import 'package:favorite_movie/screens/dashboard.dart';
import 'package:favorite_movie/screens/favorite.dart';
import 'package:favorite_movie/service/favotiteMovieDelete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: Favorite(),
        image: Image.asset('assets/images/logo.png'),
        backgroundColor: Color.fromRGBO(39, 78, 78, 1),
        photoSize: 180.0,
        loaderColor: Colors.yellow,
      ),
    );
  }
}
