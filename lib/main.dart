import 'package:favorite_movie/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';
import 'package:provider/provider.dart';
import 'package:favorite_movie/models/global_provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<GlobalProvider>(
      create: (_) => GlobalProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        home: SplashScreen(),
      ),
    );
  }
}
