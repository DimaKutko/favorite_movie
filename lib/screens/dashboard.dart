import 'package:favorite_movie/service/getrecomended.dart';
import 'package:favorite_movie/service/movielist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';
import 'package:flutter/services.dart';
import 'package:ribbon/ribbon.dart';
import 'dart:convert';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Color pink = Color.fromRGBO(236, 37, 65, 1);
  int index1 = 0, index2 = 1, index3 = 2;
  String rposter;
  String rtitle, ryear;

  var _listmovie;
  getListMovie() async {
    final listmovie = await ListMovie().getFavoriteMovie();
    final _recomended = await RecomendedIml().getrecomended();
    _listmovie = listmovie;
    rposter = jsonDecode(jsonEncode(_recomended.poster));
    rtitle = jsonDecode(jsonEncode(_recomended.title));
    ryear = jsonDecode(jsonEncode(_recomended.year));

    setState(() {});
  }

  @override
  void initState() {
    getListMovie();

    super.initState();
  }

  Widget movieCard(int indx) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.34),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            image: DecorationImage(
              image: NetworkImage('${_listmovie[indx].poster}'),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.1),
                  Color.fromRGBO(0, 0, 0, 0.2),
                  Color.fromRGBO(0, 0, 0, 0.2),
                  Color.fromRGBO(0, 0, 0, 0.2),
                  Color.fromRGBO(0, 0, 0, 0.8),
                  Color.fromRGBO(0, 0, 0, 1),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                    ),
                    child: Text(
                      '${_listmovie[indx].title}',
                      softWrap: true, //перенос строки
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: pink,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, top: 3, bottom: 3),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '(${_listmovie[indx].year})',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget _buildData() {
    if (rtitle == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                Padding(
                  padding:  EdgeInsets.only(top: 15.0),
                  child: Text('Loading',
                  style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                )
          ],
        ),
      );
    } else {
      return Center(
        child: GridView.count(
          crossAxisCount: 2,
          controller: new ScrollController(keepScrollOffset: false),
          childAspectRatio: 0.66, // size, standart = 1.0
          children: <Widget>[
            movieCard(index1),
            movieCard(index2),
            movieCard(index3),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
              child: Ribbon(
                nearLength: 55,
                farLength: 70,
                location: RibbonLocation.topStart,
                color: pink,
                title: 'Recommended',
                titleStyle: TextStyle(
                  fontSize: 10,
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.34),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      image: DecorationImage(
                        image: NetworkImage('${rposter}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(0, 0, 0, 0.2),
                            Color.fromRGBO(0, 0, 0, 0.2),
                            Color.fromRGBO(0, 0, 0, 0.2),
                            Color.fromRGBO(0, 0, 0, 0.2),
                            Color.fromRGBO(0, 0, 0, 0.8),
                            Color.fromRGBO(0, 0, 0, 1),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 5,
                              ),
                              child: Text(
                                '${rtitle}',
                                softWrap: true, //перенос строки
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: pink,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 5, top: 3, bottom: 3),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '(${ryear})',
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 1),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, // white status bar ios
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: _buildData(),
                ),
              ),
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
