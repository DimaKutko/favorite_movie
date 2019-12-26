import 'package:favorite_movie/service/omdb_api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Movie {
  final String title;
  final String year;
  final String imdbid;
  final String poster;

  Movie({
    this.title,
    this.year,
    this.imdbid,
    this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      year: json['Year'],
      imdbid: json['imdbID'],
      poster: json['Poster'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'imdbid': imdbid,
      'poster': poster,
    };
  }
}

class SearchMovieDowoland extends StatefulWidget {
  SearchMovieDowoland({Key key}) : super(key: key);

  @override
  _SearchMovieDowolandState createState() => _SearchMovieDowolandState();
}

class _SearchMovieDowolandState extends State<SearchMovieDowoland> {
  String _data;
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
      _data = jsonEncode(list);
      _title = jsonDecode(jsonEncode(list.title));
      _year = jsonDecode(jsonEncode(list.year));
      _imdbid = jsonDecode(jsonEncode(list.imdbid));
      _poster = jsonDecode(jsonEncode(list.poster));
      _poster.trim();
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
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
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
}
