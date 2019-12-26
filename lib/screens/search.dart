import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';
import 'package:favorite_movie/Models/movie_info.dart';


class Search extends StatelessWidget {
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
                child: MyCalulateArea(),
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

class MyCalulateArea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyCalulateAreaState();
}

class MyCalulateAreaState extends State<MyCalulateArea> {
  final _formKey = GlobalKey<FormState>(); // for TextForm
  String _name, name;

  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          SizedBox(height: 10.0),
          Text(
            'Search movie:',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          SizedBox(height: 10.0),
          Container(
            width: 380,
            child: TextFormField(
              style: TextStyle(color: Colors.red),
              decoration: InputDecoration(
                  labelText: 'Title movie',
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(),
                  )),
              validator: (value) {
                if (value.isEmpty) return 'Enter title movie';
              },
            ),
          ),
          SizedBox(height: 10.0),
          CupertinoButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                setState(() {
                  if (_name is String) name = _name;
                });
              }
            },
            child: Text(
              'Search',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            color: Color.fromRGBO(253, 191, 80, 1),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Row(
              children: <Widget>[
                SizedBox(width: 10.0),
                SearchMovieDowoland(),
                SizedBox(width: 10.0),
              ],
            ),
          ),
          SizedBox(height: 10.0),
        ]));
  }
}
