import 'package:favorite_movie/models/GlobalProvider.dart';
import 'package:favorite_movie/screens/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Color pink = Color.fromRGBO(236, 37, 65, 1);
  Color white = Color.fromRGBO(255, 255, 255, 1);
  Color grey = Color.fromRGBO(21, 21, 23, 1);
  final _login = GlobalKey<FormState>();
  final _passwd = GlobalKey<FormState>();
  String passwd;

  @override
  Widget _buildData() {
    final provider = Provider.of<GlobalProvider>(context);
    provider.getToken;

    if (provider.getToken == null){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 70,
        ),
        Center(
          child: SizedBox(
              height: 140,
              child: Image.asset(
                'assets/images/LogoFM.png',
              )),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Favorie ',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: pink,
              ),
            ),
            Text(
              'Movie',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 40, left: 10, right: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: pink, width: 1),
            ),
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      'Login: ',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Form(
                      key: _login,
                      child: TextFormField(
                        cursorColor: Colors.white,
                        enableInteractiveSelection: false,
                        textInputAction:
                            TextInputAction.done, //keyboard button type
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration.collapsed(
                          border: InputBorder.none,
                          hintText: null,
                        ),
                        onFieldSubmitted: (term) {
                          setState(() {
                            FocusScope.of(context).requestFocus(FocusNode());
                          });
                        },
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        validator: (value) {
                          if (value.isEmpty) return null;
                        },

                        onSaved: (value) {
                          setState(() {
                            provider.setToken = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: pink, width: 1),
            ),
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      'Password: ',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Form(
                      key: _passwd,
                      child: TextFormField(
                        obscureText: true,
                        cursorColor: Colors.white,
                        enableInteractiveSelection: false,
                        textInputAction:
                            TextInputAction.done, //keyboard button type
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration.collapsed(
                          border: InputBorder.none,
                          hintText: null,
                        ),
                        onFieldSubmitted: (term) {
                          setState(() {
                            FocusScope.of(context).requestFocus(FocusNode());
                          });
                        },
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        validator: (value) {
                          if (value.isEmpty) return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            passwd = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 30),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            height: 40,
            child: RaisedButton(
              color: grey,
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 21, fontWeight: FontWeight.bold, color: pink),
              ),
              onPressed: () {
                _passwd.currentState.save();
                if (passwd == '123456') {
                  _login.currentState.save();
                  print(provider.getToken);
                }
              },
            ),
          ),
        ),
      ],
    );}else{
      return Favorite();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // white status bar ios
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _buildData(),
      ),
    );
  }
}
