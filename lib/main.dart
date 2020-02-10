import 'package:favorite_movie/screens/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';
import 'package:provider/provider.dart';
import 'models/searchToCreate.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<CreateModel>(
      create: (_) => CreateModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        home: Favorite(),
      ),
    );
  }
}
