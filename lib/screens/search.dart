import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';
import 'package:favorite_movie/service/omdb_api.dart';


class Search extends StatelessWidget {
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
                child: SearchF(),
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

class SearchF extends StatefulWidget {
  SearchF({Key key}) : super(key: key);

  @override
  _SearchFState createState() => _SearchFState();
}

class _SearchFState extends State<SearchF> {
  final _formKey = GlobalKey<FormState>(); // for TextForm

  MovieServiceImpl search = MovieServiceImpl();

  String name;
  String _title;
  String _year;
  String _imdbid;
  String _poster;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    final list = await MovieServiceImpl().getMovieInfo();

    setState(() {
      _title = jsonDecode(jsonEncode(list.title));
      _year = jsonDecode(jsonEncode(list.year));
      _imdbid = jsonDecode(jsonEncode(list.imdbid));
      _poster = jsonDecode(jsonEncode(list.poster));
      _poster.trim();
      print("$_year");
    });
  }

  Widget _buildData() {
    if (_title == 'null') {
      return null;
    } else {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromRGBO(253, 191, 80, 1), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Color.fromRGBO(39, 58, 58, 1),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Image.network(
                  '$_poster',
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Text(
                      '$_title',
                      style: TextStyle(fontSize: 27, color: Colors.white),
                    ),
                    Text(
                      'Year: $_year    IMDBid: $_imdbid',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add),
                          color: Color.fromRGBO(253, 191, 80, 1),
                          iconSize: 35,
                          onPressed: () {},
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
        child: Column(children: <Widget>[
          Center(
            child: Text(
              'Search movie:',
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          ),
          SizedBox(height: 10.0),
          Center(
              child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(39, 58, 58, 1),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Color.fromRGBO(253, 191, 80, 1), width: 1),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    cursorColor: Color.fromRGBO(253, 191, 80, 1),
                    style: TextStyle(
                      color: Color.fromRGBO(253, 191, 80, 1),
                    ),
                    autofocus: false,
                    validator: (value) {
                      if (value.isEmpty) return 'Enater name movie: ';
                      try {
                        name = value;
                      } catch (e) {
                        name = null;
                        return e.toString();
                      }
                    }),
              ),
            ),
          )),
          SizedBox(
            height: 15,
          ),
          Center(
            child: CupertinoButton(
              child: Text(
                'Search',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              color: Color.fromRGBO(253, 191, 80, 1),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    if (name is String) search.name = name;
                  });
                }
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '$name',
            style: TextStyle(fontSize: 45, color: Colors.white),
          ),
          Container(
            child: _buildData(),
          ),
        ]));
  }
}
