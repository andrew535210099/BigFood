import 'package:duds/UserData/userdata.dart';
import 'package:flutter/material.dart';
import 'user_provider.dart';


class UserProvider with ChangeNotifier {
  String _email = '';
  String _username = '';
  String _password = '';
  int _a = 0;
  int _b = 0;
  int _c = 0;
  int _d = 0;
  int _e = 0;
  int _f = 0;
  UserData _userData = UserData();
  
  String get username => _username;
  String get email => _email;
  String get password => _password;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setValueCart(int a){
    _a = a;
    notifyListeners();
  }

  int getValueCart(){
    return _a;

  }

  void setUsername(String username){
    _username = username;
    notifyListeners();
  }

  void setPassword(String password){
    _password = password;
    notifyListeners();
  }
  
  String getUsername() {
    return _username;
  }
  String getEmail() {
    return _email;
  }

  String getPassword(){
    return _password;
  }

  UserData getUserData() {
    return _userData;
  }

  final Map<String, int> _cartData = {
    'burgerQuantity' : 0,
    'zingerBurgerQuantity' :0,
    'rollParathaQuantity' : 0,
    'sandwichQuantity': 0,
    'pizzaRollQuantity': 0, 
    'mushroomSoupQuantity': 0,
    
  };

  Map<String, int> get cartData => _cartData;

  void updateCartData(Map<String, int> data) {
    _cartData.clear();
    _cartData.addAll(data);
    notifyListeners();
  }

  

}
