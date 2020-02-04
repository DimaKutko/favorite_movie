import 'package:favorite_movie/models/loginModel.dart';
import 'package:favorite_movie/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginkey = GlobalKey<FormState>();
  final _password = GlobalKey<FormState>();
  
  
  String _tokenid;
  String _login;
  
  
  Widget login() {
    if (_tokenid == null ) {
      return Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Favorite movie'),
              Form(
                key: _loginkey,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return null;
                  },
                  onSaved: (value) {
                    _login = value;
                  },
                ),
              ),
              Form(
                key: _password,
                child: TextFormField(),
              ),
              SizedBox(
                height: 15,
              ),
              Center(child:
                  Consumer<LoginModel>(builder: (context, loginToken, child) {
                return CupertinoButton(
                  child: Text('Login'),
                  color: Colors.blue,
                  onPressed: () {
                    if (_loginkey.currentState.validate()) {
                      _loginkey.currentState.save();
                      loginToken.auth(_login);
                      setState(() {
                        _tokenid = loginToken.tokenid;
                      });
                    }
                  },
                );
              }))
            ],
          ),
        ),
      ));
    } else {
      return Dashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider<LoginModel>(
        create: (context) => LoginModel(),
        child: Center(
          child: login(),
        ));
  }
}
