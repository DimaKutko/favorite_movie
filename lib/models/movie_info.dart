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

class WMovie extends StatefulWidget {
  WMovie({Key key}) : super(key: key);

  @override
  _WMovieState createState() => _WMovieState();
}

class _WMovieState extends State<WMovie> {
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
      return Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15,),
            Image.network('$_poster', 
            width: 140,),
            SizedBox(height: 5,),
            Text(
              "Title: $_title ",
              style: TextStyle(color: Colors.white, fontSize: 23 ),
            ),
            Text(
              "Year: $_year",
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
            Text(
              "IMDB id: $_imdbid",
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          ],
        ),
      );
    }
  }
}