import 'package:flutter/material.dart';
import 'package:property_app/home/item_card.dart';
import 'package:property_app/home/property_item.dart';
import 'package:property_app/home/search.dart';

import 'filter_button.dart';

class Home extends StatefulWidget {
  List<PropertyItem> items;
  VoidCallback? refresh;
  Home({required this.items, this.refresh}){

  }
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: size.width,
            height: 40,
            margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom:10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Search(),
                FilterButton(),
              ],
            ),
          ),
          Container(
            width: size.width,
            height: size.height-80,
            child: ListView(
              children: widget.items.map((e) =>
                ItemCard(
                  propertyItem: e,
                  refresh: widget.refresh,
                )
              ).toList(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.brown,
    );
  }
}
