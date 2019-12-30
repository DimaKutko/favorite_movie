import 'package:favorite_movie/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:favorite_movie/routes/route.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(CupertinoApp(
  
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Dashboard(),
      image: Image.asset('assets/images/logo.png'),
      backgroundColor: Color.fromRGBO(39, 78, 78, 1),
      photoSize: 180.0,
      loaderColor: Colors.yellow,
      
    );
  }
}
