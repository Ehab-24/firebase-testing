

import 'package:flutter/material.dart';

class TextStyles{

  static TextStyle interactable(double size) => TextStyle(
        color: Colors.orange,
        fontSize: size,
        fontWeight: FontWeight.w200,
      );
  static TextStyle button1(double size) => TextStyle(
      color: Colors.grey.shade900,
      fontSize: size,
      fontWeight: FontWeight.w500,
    );
  static const TextStyle inputField = TextStyle(
      color: Color.fromRGBO(238, 238, 238, 1),
      fontWeight: FontWeight.w300,
      letterSpacing: 0.8
    );
  static const TextStyle appBarHeader = TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.w100,
    );
  static const TextStyle header1 = TextStyle(
      color: Color.fromRGBO(33, 33, 33, 1),
      fontSize: 50,
      fontWeight: FontWeight.w900
    ); 
}