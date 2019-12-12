import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/screens/account.dart';
import 'package:favorite_movie/routes/route.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() =>  _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds:  Account(),
      image: Image.asset('assets/images/logo.png'),
      gradientBackground:  LinearGradient(
          colors: [Colors.grey[700], Colors.grey[900]],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,),
      photoSize: 180.0,
      styleTextUnderTheLoader: TextStyle(),
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.yellow,
    );
  }
}
