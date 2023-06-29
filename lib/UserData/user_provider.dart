import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _email = '';
  String _username = '';
  
  String get username => _username;
  String get email => _email;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setUsername(String username){
    _username = username;
    notifyListeners();
  }
  
  String getUsername() {
    return _username;
  }
  String getEmail() {
    return _email;
  }
}