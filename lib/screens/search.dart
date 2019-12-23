import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';


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
                child: FormSearch(),
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

class FormSearch extends StatefulWidget {
  @override
  _FormSearchState createState() => _FormSearchState();
}

class _FormSearchState extends State<FormSearch> {
  final formKey = GlobalKey<FormState>();
  String _name, name1;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
            child: Column(
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Text(
          'Title movie:',
          style: TextStyle(fontSize: 23.0, color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Container(
            width: 330,
            child: Form(
              key: formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title movie',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                              color: Colors.red,
                            ),
                          )
                ),
                validator: (input) => !input.contains(null) ? 'Enter title movie':null,
                onSaved: (input) => _name = input,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 200,
          
          child: CupertinoButton(
            child: Text(
              'Search',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            color: Color.fromRGBO(39, 58, 58, 1),
            onPressed: _inputname,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '$_name',
          style: TextStyle(color: Colors.red),
        ),
      ],
    )
  )
);
}
void _inputname() async{
  if(formKey.currentState.validate()){
      formKey.currentState.save();
      print(_name);
  }
}
}