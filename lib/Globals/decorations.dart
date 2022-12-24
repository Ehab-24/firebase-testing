
import 'package:flutter/material.dart';
import 'package:firebase_testing/Globals/shadows.dart';

class Decorations{

  static BoxDecoration appBarHeader = BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade700, Colors.orange.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: Shadows.appBar,
    );
}