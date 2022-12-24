import 'package:flutter/material.dart';

class Shapes{

  static ShapeBorder appBar(double w) => RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(w/2, 50),
          bottomRight: Radius.elliptical(w/2, 50),
        ),
      );
}