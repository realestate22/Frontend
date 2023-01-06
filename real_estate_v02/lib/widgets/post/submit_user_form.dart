import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:real_estate_v02/widgets/text_widget.dart';

import '../default_property.dart';

class SubmitUserForm extends StatelessWidget {
  IconData? prefixIcon;
  String text;
  VoidCallback action;
  late double fontSize;
  double? width;
  double? buttonSize;
  Color backgroundColor;
  Color foregroundColor;
  late Color iconColor;
  late FocusNode focusNode;
  Widget? icon;

  SubmitUserForm({super.key,
    required this.text,
    required this.action,
    this.prefixIcon,
    this.width,
    this.buttonSize,
    double? fontSize,
    this.backgroundColor=Colors.white,
    this.foregroundColor=Colors.black,
    Color? iconColor,
    Widget? icon,
  }){
    this.fontSize = fontSize ?? DefaultProperty.instance.sizes.defaultFontSize;
    this.iconColor = iconColor ?? foregroundColor;
    focusNode=FocusNode();
    if(icon==null && prefixIcon!=null){
      this.icon = Icon(
        prefixIcon!,
        color: this.iconColor,
        size: buttonSize,
      );
    } else if(icon!=null){
      this.icon=SizedBox(
        height: buttonSize ?? fontSize,
        child: icon,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    log('submit_built');
    if(icon==null){
      return Container(
        height: DefaultProperty.instance.sizes.defaultFontSize*3,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: DefaultProperty.instance.sizes.defaultFontSize,
                offset: Offset(0, DefaultProperty.instance.sizes.defaultFontSize /2 ),
                color: Colors.grey,
                spreadRadius: -DefaultProperty.instance.sizes.defaultFontSize / 2
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: action,
          focusNode: focusNode,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              backgroundColor
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  DefaultProperty.instance.spacing.buttonBorderRadius
                ),
              )
            )
          ),
          child: TextWidget(
            text: text,
            family: "Avenir",
            size: fontSize,
            color: foregroundColor
          ),
        ),
      );
    }else{
      return Container(
        height: DefaultProperty.instance.sizes.defaultFontSize*3,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: DefaultProperty.instance.sizes.defaultFontSize,
                offset: Offset(0, DefaultProperty.instance.sizes.defaultFontSize/2),
                color: Colors.grey,
                spreadRadius: -DefaultProperty.instance.sizes.defaultFontSize/2
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: action,
          focusNode: focusNode,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              backgroundColor
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    DefaultProperty.instance.spacing.buttonBorderRadius
                ),
              )
            )
          ),
          icon: icon!,
          label: TextWidget(
            text: text,
            family: "Avenir",
            size: fontSize,
            color: foregroundColor
          ),
        ),
      );
    }
  }
}
