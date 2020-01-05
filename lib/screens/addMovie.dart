import 'package:favorite_movie/routes/route.dart';
import 'package:flutter/material.dart';

class AddMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 78, 78, 1),
      body: Column(
        children: <Widget>[
          Top(),
          Expanded(
            child: Container(
              child: Center(
                child: AddMovieF(),
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

class AddMovieF extends StatefulWidget {
  @override
  _AddMovieFState createState() => _AddMovieFState();
}

class _AddMovieFState extends State<AddMovieF> {
  String _id;
  String _title;
  String _year;
  String _poster;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('$_poster'),
          fit: BoxFit.fill,
        ),
      ),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text(
            '$_id',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
          Text(
            '$_title',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
          Text(
            '$_year',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }
}
