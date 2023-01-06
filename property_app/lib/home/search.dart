import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Container(
      width: size.width*3/4,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10,10,10,0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          alignLabelWithHint: true,
          fillColor: Colors.white30,
          filled: true,
          hintText: "Search:",
          hintStyle: TextStyle(
            color: Colors.white,
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
    );
  }
}
