import 'package:flutter/material.dart';
import 'dart:developer';

class ScreenController extends ChangeNotifier{
  int? _currentPage;
  int? _difference;
  bool _fromAppBar = false;

  setCurrentPage(int value) {
    if(_currentPage!=null){
      setDifference((value-_currentPage!).abs());
    }
    _currentPage = value;
    log("On page: $value");

    notifyListeners();
  }

  int getCurrentPage(){
    if(_currentPage==null){
      return -1;
    }
    return _currentPage!;
  }

  setDifference(int difference) {
    _difference=difference;
  }

  int getDifference(){
    if(_difference==null){
      return 0;
    }
    return _difference!;
  }

  setFromAppBar(bool fromAppBar) {
    _fromAppBar=fromAppBar;
  }

  bool isFromAppBar(){
    return _fromAppBar;
  }

  ScreenController({int? initialPage}){
    if(initialPage!=null){
      setCurrentPage(initialPage);
    }
  }



}
