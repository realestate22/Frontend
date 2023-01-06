import 'dart:developer';

import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier{
  Map<String, bool> allItems;

  ItemProvider({required this.allItems}){

  }

  update(String key){
    if(allItems.containsKey(key)){
      allItems[key]=!(allItems[key] as bool);
    }else{
      log("key not contained");
    }
    notifyListeners();
  }

  List<String> getBookmarkedItemIDs(){
    return allItems.entries.where((element) => element.value).map((e) => e.key).toList();
  }

}