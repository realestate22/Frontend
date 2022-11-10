
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:property_app/home/item_card.dart';
import 'package:property_app/home/property_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                SizedBox(
                  width: size.width*3/4,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10,10,10,0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white
                      ),
                      alignLabelWithHint: true,
                      fillColor: Colors.white30,
                      filled: true,
                      hintText: "Search:",
                      hintStyle: TextStyle(
                        color: Colors.white
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                    },
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                    onSubmitted: (value) {
                      print("Enter: "+value);
                    },
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: (){},
                    icon: const FaIcon(
                      FontAwesomeIcons.filter,
                      color: Colors.blue,
                      size: 20,
                    )
                  ),
                )
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
