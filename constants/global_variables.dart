import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//String uri = 'https://new-export.herokuapp.com';
String uri = 'http://192.168.1.104:5000';
class GlobalVariables {
  static var formatter = NumberFormat.decimalPattern('RU');
  static var dtFormat = DateFormat('dd.MM.yy / HH:mm');
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const warningColor = Colors.deepOrange;
  static const lightColor = Colors.grey;

  static const bankItem = [
    'Asia Alliance Bank',
    'Капиталбанк',
    'Народный банк',
    'Ипак Йули Банк',
    'Асакабанк',
    'Агробанк',
    'Ипотека банк',
    'НБУ',
    'Турон банк',
    'Инфинбанк',
    'Алокабанк',
    'Hamkorbank',
    'Узпромстройбанк',
    'Микрокредитбанк',
    'Ориент Финанс Банк',
    'Пойтахт банк',
    'TBC Bank',
    'Кишлок курилиш банк',
    'Tenge Bank',
    'Ziraat Bank',
    'Узагроэкспортбанк',
    'Универсал банк',
    'Ravnaq-bank',
    'Савдогар банк',
    'Мадад Инвест Банк',
    'КДБ Банк Узбекистан',
    'Садерат Банк',
    'Туркистон Банк',
    'Hi-Tech Bank',
    'Apelsin',
  ];

  static const currencyItem = [
    'Валюта',
    'UZS',
    'USD',
    'EUR',
    'RUB',
  ];
}