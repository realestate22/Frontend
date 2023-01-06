import 'package:flutter/material.dart';
import 'dart:developer';

import '../default_property.dart';
class IconChange extends StatefulWidget {
  IconData shownData;
  late IconData notShownData;
  Color shownColor;
  late Color notShownColor;
  double? iconSize;
  bool shown;
  VoidCallback action;

  IconChange({
    required this.shownData,
    required this.shownColor,
    IconData? notShownData,
    Color? notShownColor,
    this.iconSize,
    this.shown = true,
    required this.action
  }){
    this.notShownData = notShownData ?? shownData;
    this.notShownColor = notShownColor ?? shownColor;
  }

  @override
  State<IconChange> createState() => _IconChangeState();
}

class _IconChangeState extends State<IconChange> {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(
          DefaultProperty.instance.spacing.defaultPaddingInputSize
      ),
      constraints: BoxConstraints(),
      onPressed: widget.action,
      icon: Icon(
        widget.shown ? widget.shownData : widget.notShownData,
        color: widget.shown ? widget.shownColor : widget.notShownColor,
      ),
      iconSize: widget.iconSize,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
    );
  }
}

