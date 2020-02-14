import 'package:favorite_movie/models/GlobalProvider.dart';
import 'package:favorite_movie/routes/navigatioBottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Color pink = Color.fromRGBO(236, 37, 65, 1);
  Color white = Color.fromRGBO(255, 255, 255, 1);
  Color grey = Color.fromRGBO(21, 21, 23, 1);
  void initState() {
    super.initState();
  }

  @override
  Widget _build() {
    final provider = Provider.of<GlobalProvider>(context);
    provider.settingsSetColor();

    return Column(

      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Top(),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: pink, width: 1),
              color: provider.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Center(
              child: SwitchListTile(
                title: Text(
                  'Light theme',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: provider.textColor),
                ),
                inactiveTrackColor: provider.textColor,
                activeColor: pink,
                value: provider.getThemColor,
                onChanged: (bool value) {
                  setState(() {
                    provider.setThemColor = value;
                  });
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            height: 40,
            child: RaisedButton(
              color: grey,
              child: Text(
                "Logout",
                style: TextStyle(
                    fontSize: 21, fontWeight: FontWeight.bold, color: pink),
              ),
              onPressed: () {
                provider.setToken = null;
                Navigator.pushNamed(context, '/login');
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: provider.statusbar, // white status bar ios
        child: Container(
          color: provider.backgroundColor,
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
      ),
    );
  }
}
