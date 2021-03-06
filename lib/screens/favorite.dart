import 'package:favorite_movie/models/favorite_movie.dart';
import 'package:favorite_movie/models/global_provider.dart';
import 'package:favorite_movie/routes/navigatio_bottom.dart';
import 'package:favorite_movie/service/favotite_movie_delete.dart';
import 'package:favorite_movie/service/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  Favorite({Key key}) : super(key: key);
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<FavoriteMovie> _listmovie;
  Color greyback = Color.fromRGBO(0, 0, 0, 0.5);
  Color pink = Color.fromRGBO(236, 37, 65, 1);
  Color white = Color.fromRGBO(255, 255, 255, 1);

  getListMovie(String token) async {
    final listmovie = await ListMovie(token).getFavoriteMovie();
    _listmovie = listmovie;

    FavoriteMovie temporary;
    int long = _listmovie.length;
    //sorting timestamp
    for (int i = 0; i < long - 1; i++) {
      bool check = true;
      for (int j = 0; j < long - i - 1; j++) {
        if (_listmovie[j].timestamp < _listmovie[j + 1].timestamp) {
          temporary = _listmovie[j];
          _listmovie[j] = _listmovie[j + 1];
          _listmovie[j + 1] = temporary;
          check = false;
          setState(() {});
        }
      }
      if (check) break;
    }
    setState(() {});
  }

  @override
  Widget infoString(String name, String data) {
    final provider = Provider.of<GlobalProvider>(context);
    return Row(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$name: ',
            softWrap: true, //перенос строки
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: provider.textColor,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "$data ",
            softWrap: true, //перенос строки
            style: TextStyle(
              fontSize: 17,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: provider.textColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    final provider = Provider.of<GlobalProvider>(context, listen: false);
    getListMovie(provider.getToken);
    super.initState();
  }

  @override
  Widget _buildData() {
    final provider = Provider.of<GlobalProvider>(context);
    provider.favoriteSetColor();
    if (_listmovie == null) {
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
      if (_listmovie.length == 0) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Container(
            child: Center(
              child: Text(
                'You dont have favorite movies.',
                style: TextStyle(fontSize: 19, color: provider.textColor),
              ),
            ),
          ),
        );
      } else {
        return Container(
          color: Color.fromRGBO(39, 58, 58, 0),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            itemCount: _listmovie.length,
            itemBuilder: (context, index) {
              String id = _listmovie[index].id;
              String title = _listmovie[index].title;
              String year = _listmovie[index].year;
              String poster = _listmovie[index].poster;
              String label = _listmovie[index].label;
              int priority = _listmovie[index].priority;
              bool viewed = _listmovie[index].viewed;
              int rating = _listmovie[index].rating;
              int timestamp = _listmovie[index].timestamp;
              var date = DateFormat.yMMMd().format(
                  DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000));
              String prioritString;
              String viewedString;
              if (priority == 0) prioritString = "High";
              if (priority == 1) prioritString = "Medium";
              if (priority == 2) prioritString = "Low";
              if (viewed) viewedString = "Viewed";
              if (!viewed) viewedString = "Not viewed";

              return GestureDetector(
                onTap: () {
                  provider.setEditMovie = _listmovie[index];
                  Navigator.pushNamed(
                    context,
                    '/edit',
                  );
                },
                child: Dismissible(
                  key: Key(id),
                  onDismissed: (direction) {
                    setState(() {
                      FavoriteMovieDel(id, provider.getToken)
                          .favoriteMovieDel();
                      _listmovie.removeAt(index);
                    });
                  },
                  background: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: pink, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Icon(
                        Icons.cancel,
                        size: 40,
                        color: pink,
                      ),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 203,
                        decoration: BoxDecoration(
                          border: Border.all(color: pink, width: 1),
                          color: provider.backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 203,
                              width: 140,
                              child: Center(
                                child: Container(
                                  height: 193,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    image: DecorationImage(
                                      image: NetworkImage('$poster'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: double.infinity,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(5.0)),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color.fromRGBO(236, 37, 65, 0.1),
                                            Color.fromRGBO(236, 37, 65, 0.2),
                                            Color.fromRGBO(236, 37, 65, 0.3),
                                            Color.fromRGBO(236, 37, 65, 0.4),
                                            Color.fromRGBO(236, 37, 65, 0.5),
                                            Color.fromRGBO(236, 37, 65, 0.6),
                                            Color.fromRGBO(236, 37, 65, 1),
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$viewedString',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            color: Color.fromRGBO(
                                                255, 244, 255, 0.9),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 5, right: 5),
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '$title',
                                          softWrap: true, //перенос строки
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: pink,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '($year)',
                                          softWrap: true, //перенос строки
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: provider.textColor,
                                          ),
                                        ),
                                      ),
                                      infoString("Label", label),
                                      infoString("Priority", prioritString),
                                      infoString("Rating", "(${rating}/10)"),
                                      infoString("Added", "$date"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: provider.statusbar, // white status bar ios
      child: Scaffold(
        backgroundColor: provider.backgroundColor,
        body: Column(
          children: <Widget>[
            Top(),
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(child: _buildData()),
                ],
              ),
            ),
            NavigationBotom()
          ],
        ),
      ),
    );
  }
}
