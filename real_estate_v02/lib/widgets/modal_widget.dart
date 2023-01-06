import 'dart:developer';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'hero_dialog_route.dart';

class ModalWidget extends StatelessWidget {
  static callModalWidget(BuildContext context, ModalWidget modalWidget){
    Navigator.push(context, HeroDialogRoute(builder: (context) {
      return modalWidget;
    }));
  }

  Size? size;
  Widget child;
  Math.Point<double>? position;
  BoxDecoration? boxDecoration;
  EdgeInsets? edgeSpacing;
  ModalWidget({
    required this.child,
    this.size,
    this.position,
    this.boxDecoration,
    this.edgeSpacing = const EdgeInsets.symmetric(horizontal: 20,vertical: 10)
  }){}

  @override
  Widget build(BuildContext context) {
    log(size.toString());
    log(MediaQuery.of(context).size.toString());
    size??=MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topLeft,
      margin: position==null
        ? EdgeInsets.zero
        : EdgeInsets.only(top: position!.y,left: position!.x),
      padding: edgeSpacing,
      decoration: boxDecoration?? BoxDecoration(
        color: Colors.transparent
      ),
      child: Container(
        width: size!.width,
        height: size!.height,
        child: child,
      ),
    );
  }

}
