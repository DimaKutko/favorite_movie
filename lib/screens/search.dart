import 'package:favorite_movie/models/movie_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';
import 'package:provider/provider.dart';

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
                child:SearchF(),
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
  @override
  _SearchFState createState() => _SearchFState();
}

class _SearchFState extends State<SearchF> {
  final _formKey = GlobalKey<FormState>(); // for TextForm

  Widget build(BuildContext context) {
    final name = Provider.of<GlobalName>(context);

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
                  cursorColor: Color.fromRGBO(253, 191, 80, 1),
                  style: TextStyle(
                    color: Color.fromRGBO(253, 191, 80, 1),
                  ),
                  autofocus: false,
                  validator: (value) {
                    if (value.isEmpty) return 'Enter title movie';
                  },
                ),
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
                    if (name is String) {}
                  });
                }
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: SearchMovieDowoland(),
          ),
        ]));
  }
}
