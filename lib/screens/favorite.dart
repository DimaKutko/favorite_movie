import 'package:favorite_movie/Models/favoritemovie.dart';
import 'package:favorite_movie/service/favotiteMovieDelete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 78, 78, 1),
      body: Column(
        children: <Widget>[
          Top(),
          Expanded(
            child: Container(
              child: FavoriteMovieF(),
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

class FavoriteMovieF extends StatefulWidget {
  FavoriteMovieF({Key key}) : super(key: key);
  @override
  _FavoriteMovieFState createState() => _FavoriteMovieFState();
}

class _FavoriteMovieFState extends State<FavoriteMovieF> {
  List<FavoriteMovie> _favoritemovie = List<FavoriteMovie>();

  Future<List<FavoriteMovie>> getFavoriteMovie() async {
    var response = await http.get(
        'https://video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos',
        headers: {
          'token': 'dima',
        });

    var favoritemovie = List<FavoriteMovie>();

    if (response.statusCode == 200) {
      var fm = json.decode(response.body);
      for (var fm in fm) {
        favoritemovie.add(FavoriteMovie.fromJson(fm));
      }
    }
    return favoritemovie;
  }

  @override //viewed true or falsr icons
  Widget viewedF(bool viewed) {
    if (viewed == false) {
      return Icon(Icons.check_box,
          size: 20, color: Color.fromRGBO(253, 191, 80, 1));
    } else {
      return Icon(
        Icons.check_box_outline_blank,
        size: 20,
        color: Color.fromRGBO(39, 58, 58, 1),
      );
    }
  }

  @override
  void initState() {
    getFavoriteMovie().then((value) {
      setState(() {
        _favoritemovie.addAll(value);
      });
    });
    super.initState();
  }

  Widget _buildData() {
    if (_favoritemovie.length == 0) {
      return Center(
          child: Text(
        'Sorry you dont have favorite movies',
        style: TextStyle(color: Color.fromRGBO(253, 191, 80, 1), fontSize: 25),
      ));
    } else {
      return Container(
          color: Color.fromRGBO(39, 58, 58, 0),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            itemCount: _favoritemovie.length,
            itemBuilder: (context, index) {
              String id = _favoritemovie[index].id;
              String title = _favoritemovie[index].title;
              String year = _favoritemovie[index].year;
              String poster = _favoritemovie[index].poster;
              String label = _favoritemovie[index].label;
              int priority = _favoritemovie[index].priority;
              bool viewed = _favoritemovie[index].viewed;
              int rating = _favoritemovie[index].rating;
              int timestamp = _favoritemovie[index].timestamp;

              return Dismissible(
                key: Key(id),
                onDismissed: (direction) {
                 // _handleClickMe();
                  setState(() {
                   // _handleClickMe();
                    FavoriteMovieDel(id).favoriteMovieDel();
                    _favoritemovie.removeAt(index);
                  });
                },
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(
                        color: Color.fromRGBO(39, 58, 58, 1), width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Icon(
                    Icons.cancel,
                    size: 23,
                    color: Colors.black,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                height: double.infinity,
                                width: 130,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('$poster'),
                                    fit: BoxFit.fill,
                                  ),
                                  border: Border.all(
                                      color: Color.fromRGBO(39, 58, 58, 1),
                                      width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            '$title ($year)',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                                color: Color.fromRGBO(
                                                    39, 58, 58, 1)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Label:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromRGBO(
                                                  39, 58, 58, 1)),
                                        ),
                                        Text(
                                          '"$label"',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 20,
                                              color: Color.fromRGBO(
                                                  39, 58, 58, 1)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Viewed',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromRGBO(
                                                  39, 58, 58, 1)),
                                        ),
                                        Container(
                                          child: viewedF(viewed),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Rating:($rating/10)',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromRGBO(
                                                  39, 58, 58, 1)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Priority:($priority/10)',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromRGBO(
                                                  39, 58, 58, 1)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'Added to: $timestamp',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromRGBO(
                                                    39, 58, 58, 1)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            },
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _buildData());
  }
}
