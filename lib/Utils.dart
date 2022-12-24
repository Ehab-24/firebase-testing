
import 'package:flutter/material.dart';

class Utils{
  
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar({String? text, Color color = const Color.fromARGB(255, 126, 21, 14)}){

    
    if(text == '' || text == null){
      return;
    }

    final SnackBar snackBar = SnackBar(
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      backgroundColor: color,
      content: Text(text), 
    );

    messengerKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
  }
}