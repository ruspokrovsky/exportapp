import 'package:exportapp/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserMng _user = UserMng(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    //projects: [],
  );

  UserMng get user => _user;

  void setUser(String user) {
    _user = UserMng.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(UserMng user) {
    _user = user;
    notifyListeners();
  }
}