import 'package:favorite_movie/service/movielist.dart';
import 'package:favorite_movie/service/favotiteMovieDelete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';
import 'package:intl/intl.dart';

class Favorite extends StatefulWidget {
  Favorite({Key key}) : super(key: key);
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var _listmovie;

  @override //viewed true or falsr icons
  Widget viewedF(bool viewed) {
    if (viewed == true) {
      return Icon(Icons.check_box,
          size: 20, color: Color.fromRGBO(253, 191, 80, 1));
    } else if (viewed == false) {
      return Icon(
        Icons.check_box_outline_blank,
        size: 20,
        color: Color.fromRGBO(39, 58, 58, 1),
      );
    }
  }

  getListMovie() async {
    final listmovie = await ListMovie().getFavoriteMovie();
    _listmovie = listmovie;
    setState(() {});
  }

  @override
  void initState() {
    getListMovie();

    super.initState();
  }

  Widget _buildData() {
    if (_listmovie == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor:  AlwaysStoppedAnimation<Color>(Colors.white)
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

              return Dismissible(
                key: Key(id),
                onDismissed: (direction) {
                  setState(() {
                    FavoriteMovieDel(id).favoriteMovieDel();
                    _listmovie.removeAt(index);
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
                                            'Added to: $date',
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 78, 78, 1),
      body: Column(
        children: <Widget>[
          Top(),
          Expanded(
            child: Container(child: _buildData()),
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
