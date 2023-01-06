import 'package:flutter/material.dart';

import 'default_property.dart';

class TextWidget extends StatelessWidget {
  String text;
  Color color;
  double? size;
  String? family;
  double? lineHeight;

  TextWidget({
    required this.text,
    this.color=Colors.black,
    this.size,
    this.family,
    this.lineHeight
  }){
    size ??= DefaultProperty.instance.sizes.defaultFontSize;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: size,
        fontFamily: family,
        color: color,
        height: lineHeight
      ),
      child: Text(text),
    );
  }
}
