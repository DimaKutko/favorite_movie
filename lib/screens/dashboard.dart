import 'dart:convert';

import 'package:favorite_movie/service/omdb_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';


class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Top(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.grey[800],
                  ],
                ),
              ),
              child: Center(
                child: DashboardF(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: NavigationBotom(),
          ),
        ],
      ),
    );
  }
}

class DashboardF extends StatefulWidget {
  @override
  _DashboardFState createState() => _DashboardFState();
}

class _DashboardFState extends State<DashboardF> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // первый ряд
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      color: Colors.yellow,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      color: Colors.black,
                      child: WMovie(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: <Widget>[
                  //второй ряд
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WMovie extends StatefulWidget {
  WMovie({Key key}) : super(key: key);

  @override
  _WMovieState createState() => _WMovieState();
}

class _WMovieState extends State<WMovie> {
  String _data;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    final list = await MovieServiceImpl().getMovieInfo();
    
    setState(() {
      _data = jsonEncode(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildData(),
    );
  }

  Widget _buildData() {
    if (_data == null) {
      return CircularProgressIndicator();
    } else {
      return Center(
        child: Text(jsonEncode(_data), style: TextStyle(color: Colors.white),),
      );
    }
  }
}
