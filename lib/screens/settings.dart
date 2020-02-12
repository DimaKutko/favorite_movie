import 'package:favorite_movie/models/GlobalProvider.dart';
import 'package:favorite_movie/routes/navigatioBottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void initState() {
    super.initState();
  }

  @override
  Widget _build() {
    final provider = Provider.of<GlobalProvider>(context);
    provider.settingsSetColor();
    return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Top(),
            Expanded(
              child: _build(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: NavigationBotom(),
            ),
          ],
        ),
      ),
    );
  }
}
