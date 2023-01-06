import 'dart:convert';
import 'package:flutter/material.dart';

class ItemModel{
  String id;
  bool active;
  bool bookmarked;
  String address;
  String author;
  List<String> photo_gallery;
  List<String> video_gallery;
  String wallpaper;
  String currency;
  String description;
  bool expired;
  double latitude;
  double longitude;
  String name;
  String type;
  double price;
  List<String> features;
  List<Map<String,String>> tags;
  Map<String, String> city;
  bool cached;

  ItemModel({
    required this.id,
    required this.active,
    this.bookmarked = false,
    required this.address,
    required this.author,
    this.photo_gallery = const[],
    this.video_gallery = const[],
    required this.wallpaper,
    required this.description,
    required this.currency,
    this.expired = false,
    required this.longitude,
    required this.latitude,
    required this.name,
    required this.type,
    required this.price,
    this.features = const[],
    this.tags = const[],
    required this.city,
    this.cached = false,
  }){}

  setBookMarked(bool bookmarked){
    this.bookmarked=bookmarked;
  }

  bool getBookMarked(){
    return bookmarked;
  }


  static ItemModel importJSONForCache(String json){
    Map<String, dynamic> map=jsonDecode(json);
    return ItemModel(
      id: map["id"].toString(),
      active: map["active"].toString().toLowerCase() == "true" ? true : false ,
      bookmarked: map["bookmarked"].toString().toLowerCase()=="true" ? true : false,
      address: map["address"].toString(),
      author: map["author"].toString(),
      wallpaper: map["wallpaper"].toString(),
      currency: map["currency"].toString(),
      description: map["description"].toString(),
      expired: map["expired"].toString().toLowerCase() == "true" ? true : false,
      longitude: double.parse(map["longitude"].toString()),
      latitude: double.parse(map["latitude"].toString()),
      name: map["name"].toString(),
      type: map["type"].toString(),
      price: double.parse(map["price"].toString()),
      features: (map["features"] as List).map((e) => e as String).toList(),
      tags: (map["tags"] as List).map((e) => e as Map<String,String>).toList(),
      city: (map["city"] as Map).map((key, value) => MapEntry(key as String, value as String)),
      cached: map["cached"].toString().toLowerCase() == "true" ? true : false,
    );
  }

  static String exportJSONForCache(ItemModel itemModel){
    Map<String, dynamic> fgfgf={
      "id" : itemModel.id,
      "active" : itemModel.active.toString(),
      "bookmarked": itemModel.bookmarked.toString(),
      "address": itemModel.address,
      "author": itemModel.author,
      "wallpaper": itemModel.wallpaper,
      "currency": itemModel.currency,
      "description": itemModel.description,
      "expired": itemModel.expired.toString(),
      "latitude": itemModel.latitude.toString(),
      "longitude": itemModel.longitude.toString(),
      "name": itemModel.name,
      "type": itemModel.type,
      "price": itemModel.price,
      "features": itemModel.features,
      "tags": itemModel.tags,
      "city": itemModel.city,
      //"cached": itemModel.cached.toString()
      "cached": true.toString(),
    };


    return jsonEncode({
      "id" : itemModel.id,
      "active" : itemModel.active.toString(),
      "bookmarked": itemModel.bookmarked.toString(),
      "address": itemModel.address,
      "author": itemModel.author,
      "wallpaper": itemModel.wallpaper,
      "currency": itemModel.currency,
      "description": itemModel.description,
      "expired": itemModel.expired.toString(),
      "latitude": itemModel.latitude.toString(),
      "longitude": itemModel.longitude.toString(),
      "name": itemModel.name,
      "type": itemModel.type,
      "price": itemModel.price,
      "features": itemModel.features,
      "tags": itemModel.tags,
      "city": itemModel.city,
      //"cached": itemModel.cached.toString()
      "cached": true.toString(),
    });
  }

  @override
  String toString() {
    return {
      "id": id,
      "active" : active,
      "bookmarked": bookmarked,
      "address": address,
      "author": author,
      "photo_gallery": photo_gallery,
      "video_gallery": video_gallery,
      "wallpaper": wallpaper,
      "currency": currency,
      "description": description,
      "expired": expired,
      "latitude": latitude,
      "longitude": longitude,
      "name": name,
      "type": type,
      "price": price,
      "features": features,
      "tags": tags,
      "city": city,
      "cached": cached
    }.toString();
  }
}