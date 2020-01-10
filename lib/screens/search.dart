import 'dart:convert';
import 'package:favorite_movie/service/favoriteMovieAdd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';
import 'package:favorite_movie/service/omdb_api.dart';

class SearchF extends StatefulWidget {
  SearchF({Key key}) : super(key: key);

  @override
  _SearchFState createState() => _SearchFState();
}

class _SearchFState extends State<SearchF> {
  final _formKey = GlobalKey<FormState>(); // for TextForm

  var fruits = ['banana', 'pineapple', 'watermelon'];

  String name;
  String imdbid;
  String title;
  String year; // year from search
  String poster;
  String yearS; // year to search

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final list = await MovieServiceImpl('$name', '$yearS').getMovieInfo();

      title = jsonDecode(jsonEncode(list.title));
      year = jsonDecode(jsonEncode(list.year));
      imdbid = jsonDecode(jsonEncode(list.imdbid));
      poster = jsonDecode(jsonEncode(list.poster));
      setState(() {});
    }
    ;
  }

  Widget _buildData() {
    if (title == null) {
      return null;
    } else {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('$poster'),
              fit: BoxFit.fill,
            ),
            border:
                Border.all(color: Color.fromRGBO(253, 191, 80, 1), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Align(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromRGBO(1, 1, 1, 1),
                        Color.fromRGBO(1, 1, 1, 0.1),
                        Color.fromRGBO(1, 1, 1, 0)
                      ])),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    height: 100,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            '$title ($year)',
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle, size: 32),
                          color: Colors.white,
                          onPressed: () {
                            //FavoriteAddMovie(imdbid, title, year, poster)
                              //  .favoriteAddMovie();
                            
                          },
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    }
  }

  _showDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 300,
            child: CupertinoPicker(
              backgroundColor: Color.fromRGBO(39, 78, 78, 1),
              itemExtent: 50, //height of each item
              looping: true,
              children: List<Widget>.generate(71, (int index) {
                return Center(
                  child: Text(
                    '${index + 1950}',
                    style: TextStyle(
                      color: Color.fromRGBO(253, 191, 80, 1),
                      fontSize: 32,
                    ),
                  ),
                );
              }),
              onSelectedItemChanged: (int index) {
                int y = index + 1950;
                setState(() {
                  yearS = y.toString();
                  _getData();
                });
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, //keyboard top !!!
      backgroundColor: Color.fromRGBO(39, 78, 78, 1),
      body: Column(
        children: <Widget>[
          Top(),
          Expanded(
            child: Container(
              child: Center(
                child: Container(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 15),
                    child: Column(children: <Widget>[
                      Center(
                        child: Text(
                          'Search movie:',
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(39, 58, 58, 1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Color.fromRGBO(253, 191, 80, 1),
                                  width: 1),
                            ),
                            child: Container(
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () {
                                      _showDatePicker(context);
                                    },
                                  ),
                                  Expanded(
                                    child: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        cursorColor:
                                            Color.fromRGBO(253, 191, 80, 1),
                                        enableInteractiveSelection: false,
                                        textInputAction: TextInputAction.done,
                                        autofocus: true,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration.collapsed(
                                          hintText: "Enter title movie",
                                          border: InputBorder.none,
                                        ),
                                        onFieldSubmitted: (term) {
                                          print(yearS);
                                          setState(() {
                                            _getData();
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          });
                                        },
                                        style: TextStyle(
                                          fontSize: 23,
                                          color:
                                              Color.fromRGBO(253, 191, 80, 1),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) return null;
                                        },
                                        onSaved: (value) {
                                          name = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: _buildData(),
                      ),
                    ])),
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
    ;
  }
}
