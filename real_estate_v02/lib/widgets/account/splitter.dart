import 'package:flutter/material.dart';
import 'package:real_estate_v02/widgets/default_property.dart';
import 'package:real_estate_v02/widgets/text_widget.dart';

class Splitter extends StatelessWidget {
  double size;
  String? text;
  Splitter({
    this.text,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    if(text==null){
      return Container(
        width: double.infinity,
        height: size,
        child: Center(
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.black,
          ),
        ),
      );
    }else{
      return Container(
        width: double.infinity,
        height: size,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 1,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
               // color: Colors.greenAccent,
                child: TextWidget(
                  text: text!,
                  size: size,
                  color: Colors.black,
                  family: "Avenir",
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 1,
                  color: Colors.black,
                ),
              )
            ]
        ),
      );
    }
  }
}
