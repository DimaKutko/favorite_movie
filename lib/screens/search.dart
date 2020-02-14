import 'dart:convert';
import 'package:favorite_movie/models/GlobalProvider.dart';
import 'package:favorite_movie/routes/navigatioBottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/service/omdb_api.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SearchF extends StatefulWidget {
  SearchF({Key key}) : super(key: key);

  @override
  _SearchFState createState() => _SearchFState();
}

class _SearchFState extends State<SearchF> {
  Color pink = Color.fromRGBO(236, 37, 65, 1);
  var _movie;
  final _formKey = GlobalKey<FormState>(); // for TextForm
  String name;
  String imdbid;
  String title;
  String year; // year from search
  String poster;
  String yearS; // year to search

  void _getData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final movie = await MovieServiceImpl('$name', '$yearS').getMovieInfo();
      _movie = movie;

      title = jsonDecode(jsonEncode(movie.title));
      year = jsonDecode(jsonEncode(movie.year));
      imdbid = jsonDecode(jsonEncode(movie.imdbid));
      poster = jsonDecode(jsonEncode(movie.poster));

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildData() {
    final provider = Provider.of<GlobalProvider>(context);
    provider.searchSetColor();
    if (title == null) {
      return null;
    } else {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: GestureDetector(
            onTap: () {
              provider.setaddMovie = _movie;
              Navigator.pushNamed(
                context,
                '/create',
              );
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  image: DecorationImage(
                    image: NetworkImage('$poster'),
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
                            '$title',
                            softWrap: true, //перенос строки
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: pink,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 3, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '($year)',
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 15,
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
  }

  Widget _showDatePicker() {
    final provider = Provider.of<GlobalProvider>(context);
    return Container(
      height: 50,
      width: 50,
      child: CupertinoPicker(
        backgroundColor: provider.backgroundColor,
        itemExtent: 25, //height of each item
        looping: true,
        scrollController: FixedExtentScrollController(initialItem: 70),
        onSelectedItemChanged: (int index) {
          int y = index + 1950;
          setState(() {
            if (_formKey.currentState.validate()) {
              yearS = y.toString();
              _getData();
            }
          });
        },
        children: List<Widget>.generate(71, (int index) {
          return Center(
            child: Text(
              '${index + 1950}',
              style: TextStyle(
                color: provider.textColor,
                fontSize: 15,
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false, //keyboard top !!!
      backgroundColor: provider.backgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: provider.statusbar, // white status bar ios
        child: Column(
          children: <Widget>[
            Top(),
            Expanded(
              child: Container(
                child: Center(
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 15),
                      child: Column(children: <Widget>[
                        SizedBox(height: 10.0),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: provider.backgroundColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: pink, width: 1),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                height: 50,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          cursorColor: provider.textColor,
                                          enableInteractiveSelection: false,
                                          textInputAction: TextInputAction
                                              .done, //keyboard button type
                                          autofocus: true,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration.collapsed(
                                            border: InputBorder.none,
                                            hintText: null,
                                          ),
                                          onFieldSubmitted: (term) {
                                            setState(() {
                                              _getData();
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                            });
                                          },
                                          style: TextStyle(
                                            fontSize: 19,
                                            color: provider.textColor,
                                            fontWeight: FontWeight.bold,
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
                                    Container(
                                      child: _showDatePicker(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
      ),
    );
  }
}
