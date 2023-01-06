import 'package:flutter/material.dart';

import '../services/auth.dart';

class FireButton extends StatefulWidget {

  Color foregroundColor;
  Color backgroundColor;
  IconData? iconType;
  String label;
  double roundedSize;
  double spacing;
  VoidCallback function;
  double? width;
  LinearGradient? foregroundGradient;

  FireButton({this.iconType,
    required this.function,
    this.width,
    this.foregroundGradient,
    this.spacing = 5,
    this.label = "",
    this.roundedSize = 0,
    this.foregroundColor = Colors.black,
    this.backgroundColor = Colors.white, });

  @override
  State<FireButton> createState() => _FireButtonState();
}

class _FireButtonState extends State<FireButton> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: EdgeInsets.symmetric(vertical:widget.spacing),
      child: TextButton.icon(
        onPressed: widget.function,

        icon: Icon(
        widget.iconType,
        color: widget.foregroundColor,
        ),
        label: Text(
          widget.label,
          style: TextStyle(
            color: widget.foregroundColor,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(widget.backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.roundedSize),
            )
          )
        ),
      ),
    );
  }
}
