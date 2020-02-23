import 'package:favorite_movie/models/global_provider.dart';
import 'package:favorite_movie/routes/navigatio_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  setToken() async {
    final provider = Provider.of<GlobalProvider>(context, listen: false);
    final data = await SharedPreferences.getInstance();
    data.setString('token', null);
    data.setBool('theme', false);
    data.setBool('recommendation', true);
    data.setBool('recommendetfavorite', false);
    provider.setToken = null;
  }

  setSettings(bool value, String settings) async {
    final data = await SharedPreferences.getInstance();
    data.setBool('$settings', value);
  }

  @override
  Widget recommendetfromfavorite() {
    final provider = Provider.of<GlobalProvider>(context);
    if (provider.recommendation) {
      return Center(
        child: MergeSemantics(
          child: ListTile(
            title: Text(
              'Recommendet from favorite',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: provider.textColor),
            ),
            trailing: CupertinoSwitch(
              activeColor: pink,
              value: provider.recommendetfavorite,
              onChanged: (bool value) {
                setState(() {
                  setSettings(value, "recommendetfavorite");
                  provider.recommendetfavorite = value;
                });
              },
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 12,
      );
    }
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
            child: Column(
              children: <Widget>[
                Center(
                  child: MergeSemantics(
                    child: ListTile(
                      title: Text(
                        'Light theme',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: provider.textColor),
                      ),
                      trailing: CupertinoSwitch(
                        activeColor: pink,
                        value: provider.getThemColor,
                        onChanged: (bool value) {
                          setState(() {
                            setSettings(value, "theme");
                            provider.setThemColor = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Center(
                  child: MergeSemantics(
                    child: ListTile(
                      title: Text(
                        'Recommendation',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: provider.textColor),
                      ),
                      trailing: CupertinoSwitch(
                        activeColor: pink,
                        value: provider.recommendation,
                        onChanged: (bool value) {
                          setState(() {
                            setSettings(value, 'recommendation');
                            provider.recommendation = value;
                            setSettings(false, "recommendetfavorite");
                            provider. recommendetfavorite = false;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                recommendetfromfavorite(),
              ],
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
                "Sign out",
                style: TextStyle(
                    fontSize: 21, fontWeight: FontWeight.bold, color: pink),
              ),
              onPressed: () {
                setToken();
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
