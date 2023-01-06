import 'package:flutter/material.dart';

class HomeFilterController extends ChangeNotifier{
  String _prompt="";

  setPrompt(String prompt){
    _prompt=prompt;
    notifyListeners();
  }

  String getPrompt(){
    return _prompt;
  }

}