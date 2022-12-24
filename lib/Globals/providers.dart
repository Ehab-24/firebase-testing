
import 'package:firebase_testing/Pages/Home/HomeScreen.dart';
import 'package:flutter/cupertino.dart';

class Page_pr extends ChangeNotifier{

  int currentPageIndex = 0;

  void setPage(int index){
    if(index == currentPageIndex){
      return;
    }
    currentPageIndex = index;
    notifyListeners();
  }
}