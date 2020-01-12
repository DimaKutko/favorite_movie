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
  final _formKeyLabel = GlobalKey<FormState>(); // for TextForm

  String name;
  String imdbid;
  String title;
  String year; // year from search
  String poster;
  String yearS; // year to search
  String label;
  bool viewed = false;
  int priority = 0, rating = 0;

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
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Align(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                            _showAddMovie(context);
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
                });
              },
            ),
          );
        });
  }

  _showAddMovie(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Color.fromRGBO(0, 0, 0, 0),
            child: Center(
              child: Container(
                height: 603,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 5),
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage('$poster'),
                                      fit: BoxFit.fill,
                                    ),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 180,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          child: Center(
                                        child: Text(
                                          '$title',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      )),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                          child: Text(
                                        'Year: $year',
                                        style: TextStyle(
                                          fontSize: 21,
                                        ),
                                      )),
                                      //SizedBox(
                                      //  height: 51,
                                      //),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                        ),
                                        child: SwitchListTile(
                                          title: Text(
                                            'Viewed',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          value: viewed,
                                          activeColor: Colors.black,
                                          onChanged: (bool value) {
                                            setState(() {
                                              viewed = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              'Label: ',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                    ),
                    Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Form(
                                key: _formKeyLabel,
                                child: TextFormField(
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Enter label movie",
                                  ),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      label = value;
                                    });
                                  },
                                  onFieldSubmitted: (term) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              'Rating: ',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoPicker(
                            backgroundColor: Colors.white,
                            itemExtent: 22, //height of each item
                            looping: true,
                            children: List<Widget>.generate(11, (int index) {
                              return Center(
                                child: Text(
                                  '$index',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            }),
                            onSelectedItemChanged: (int index) {
                              setState(() {
                                rating = index;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              'Priority: ',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoPicker(
                            backgroundColor: Colors.white,
                            itemExtent: 22, //height of each item
                            looping: true,
                            children: List<Widget>.generate(11, (int index) {
                              return Center(
                                child: Text(
                                  '$index',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            }),
                            onSelectedItemChanged: (int index) {
                              setState(() {
                                priority = index;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CupertinoButton(
                            color: Colors.black,
                            child: Text('Exit'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoButton(
                            color: Color.fromRGBO(253, 191, 80, 1),
                            child: Text('Add'),
                            onPressed: () {
                              
                              setState(() {
                                _formKeyLabel.currentState.save();
                                FavoriteAddMovie(
                                  imdbid,
                                  title,
                                  year,
                                  poster,
                                  label,
                                  priority,
                                  viewed,
                                  rating,
                                ).favoriteAddMovie();
                              });

                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
                              borderRadius: BorderRadius.circular(10),
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
                                        textInputAction: TextInputAction
                                            .done, //keyboard button type
                                        autofocus: true,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration.collapsed(
                                          hintText: "Enter title movie",
                                          border: InputBorder.none,
                                        ),
                                        onFieldSubmitted: (term) {
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
