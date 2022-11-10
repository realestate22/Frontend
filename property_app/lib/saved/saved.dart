import 'package:flutter/material.dart';
import 'package:property_app/home/property_item.dart';
import 'package:property_app/home/item_card.dart';

class Saved extends StatefulWidget {
  List<PropertyItem> items=[];
  VoidCallback? refresh;
  Saved({required this.items, this.refresh}){

  }

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: widget.items.where((e) => e.bookmarked).map((e) =>
            ItemCard(propertyItem: e, refresh: widget.refresh,)).toList(),
      ),
      backgroundColor: Colors.blue,
    );
  }
}
