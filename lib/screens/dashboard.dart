import 'package:favorite_movie/models/favoritemovie.dart';
import 'package:favorite_movie/models/GlobalProvider.dart';
import 'package:favorite_movie/routes/navigatioBottom.dart';
import 'package:favorite_movie/service/getrecomended.dart';
import 'package:favorite_movie/service/movielist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ribbon/ribbon.dart';
import 'dart:convert';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Color pink = Color.fromRGBO(236, 37, 65, 1);
  List<int> index = [0, 1, 2, 3];
  String rposter;
  String rtitle, ryear;
  List<FavoriteMovie> _listmovie;
  var recomended;

  getListMovie(String token) async {
    final provider = Provider.of<GlobalProvider>(context, listen: false);
    final listmovie = await ListMovie(token).getFavoriteMovie();
    _listmovie = listmovie;

    bool check = true;
    FavoriteMovie temporary;
    int long = listmovie.length;
    // sort by priority
    if (long >= 3) {
      for (int i = 0; i < long - 1; i++) {
        check = true;
        for (int j = 0; j < long - i - 1; j++) {
          //sorting priority
          if (_listmovie[j].priority < _listmovie[j + 1].priority) {
            temporary = _listmovie[j];
            _listmovie[j] = _listmovie[j + 1];
            _listmovie[j + 1] = temporary;
            check = false;
            setState(() {});
          }
        }
        if (check) break;
      }
      //viewed = false to top of list
      for (int i = 0; i < long - 1; i++) {
        for (int j = 0; j < long - i - 1; j++) {
          if (_listmovie[j].viewed) {
            if (_listmovie[j + 1].viewed == false) {
              temporary = _listmovie[j];
              _listmovie[j] = _listmovie[j + 1];
              _listmovie[j + 1] = temporary;
              setState(() {});
            }
          }
        }
      }

      if (provider.recommendetfavorite) {
        //Disable recommendations from the movie list on this page
        do {
          final _recomended = await RecomendedIml().getrecomended();
          recomended = _recomended;
          rposter = jsonDecode(jsonEncode(_recomended.poster));
          rtitle = jsonDecode(jsonEncode(_recomended.title));
          ryear = jsonDecode(jsonEncode(_recomended.year));
          check = false;
          for (int i = 0; i < 3; i++) {
            if (_listmovie[i].title == rtitle) {
              print("Coppy");
              check = true;
            }
          }
        } while (check);
      } else {
        //Turn off recommendations from added movies to favorites
        do {
          final _recomended = await RecomendedIml().getrecomended();
          recomended = _recomended;
          rposter = jsonDecode(jsonEncode(_recomended.poster));
          rtitle = jsonDecode(jsonEncode(_recomended.title));
          ryear = jsonDecode(jsonEncode(_recomended.year));
          check = false;
          for (int i = 0; i < long; i++) {
            if (_listmovie[i].title == rtitle) {
              print("Coppy");
              check = true;
            }
          }
        } while (check);
      }
    } else {
      final _recomended = await RecomendedIml().getrecomended();
      recomended = _recomended;
      rposter = jsonDecode(jsonEncode(_recomended.poster));
      rtitle = jsonDecode(jsonEncode(_recomended.title));
      ryear = jsonDecode(jsonEncode(_recomended.year));
    }
    setState(() {});
  }

  @override
  void initState() {
    final provider = Provider.of<GlobalProvider>(context, listen: false);

    getListMovie(provider.getToken);

    super.initState();
  }

  Widget recomendet() {
    final provider = Provider.of<GlobalProvider>(context);
    return GestureDetector(
      onTap: () {
        provider.setaddMovie = recomended;
        Navigator.pushNamed(
          context,
          '/create',
        );
      },
      child: Padding(
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
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(5.0)),
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
                      padding: EdgeInsets.only(left: 5, top: 3, bottom: 5),
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
    );
  }

  Widget movieCard(int indx) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            image: DecorationImage(
              image: NetworkImage('${_listmovie[indx].poster}'),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.0)),
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
                  padding: EdgeInsets.only(left: 5, top: 3, bottom: 5),
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
    final provider = Provider.of<GlobalProvider>(context);
    provider.dashboardSetColor();
    if (rtitle == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(provider.textColor)),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                'Loading',
                style: TextStyle(fontSize: 19, color: provider.textColor),
              ),
            )
          ],
        ),
      );
    } else {
      if (_listmovie.length < 4) {
        return Padding(
          padding: EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 5),
          child: Container(
            child: recomendet(),
          ),
        );
      } else {
        if (provider.recommendation) {
          return Center(
            child: GridView.count(
              crossAxisCount: 2,
              controller: ScrollController(keepScrollOffset: false),
              childAspectRatio: 0.66, // size, standart = 1.0
              children: <Widget>[
                movieCard(index[0]),
                movieCard(index[1]),
                movieCard(index[2]),
                recomendet(),
              ],
            ),
          );
        } else {
          return Center(
            child: GridView.count(
              crossAxisCount: 2,
              controller: ScrollController(keepScrollOffset: false),
              childAspectRatio: 0.66, // size, standart = 1.0
              children: <Widget>[
                movieCard(index[0]),
                movieCard(index[1]),
                movieCard(index[2]),
                movieCard(index[3]),
              ],
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    return Scaffold(
      backgroundColor: provider.backgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: provider.statusbar, // white status bar ios
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
