import 'package:flutter/material.dart';

class LoginModel with ChangeNotifier {
  String tokenid;

  void logout() {
    tokenid = null;
    notifyListeners();
  }

  void auth(String login) {
    tokenid = login;
    print(tokenid);
    notifyListeners();
  }
}
