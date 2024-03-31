import 'package:flutter/material.dart';

class TextFieldProvider extends ChangeNotifier {
  String _str = "";

  String get resultString => _str;

  set resultString(String value) {
    _str = value;
    notifyListeners();
  }
}