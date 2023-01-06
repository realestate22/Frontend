import 'dart:developer';

import 'package:flutter/material.dart';

import '../default_property.dart';
import '../text_widget.dart';

class SelectionUserForm extends StatelessWidget {
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
  List<String> dropdownStringItems;
  bool required;
  String? actualValue;

  SelectionUserForm({
    required this.text,
    required this.action,
    this.required=true,
    this.prefixIcon,
    this.width,
    this.buttonSize,
    double? fontSize,
    this.backgroundColor=Colors.white,
    this.foregroundColor=Colors.black,
    this.dropdownStringItems = const[],
    Color? iconColor,
    this.actualValue
  }){
    this.fontSize = fontSize ?? DefaultProperty.instance.sizes.defaultFontSize;
    this.iconColor = iconColor ?? foregroundColor;
    focusNode=FocusNode();
  }

  bool isValidated(){
    if(required){
      if(actualValue==null && actualValue!.isEmpty){
        return false;
      }
      bool textIsContained=false;
      for (String element in dropdownStringItems) {
        if(element==actualValue){
          textIsContained=true;
          break;
        }
      }
      return textIsContained;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    log('selection_built');
    return Container(
      height: DefaultProperty.instance.sizes.defaultFontSize *
          (required ? 5 : 4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: DefaultProperty.instance.sizes.defaultFontSize,
            offset: Offset(0,(required ? -1 : 1) *
                DefaultProperty.instance.sizes.defaultFontSize/2),
            color:Color.fromRGBO(0,0,0,0.1),
            spreadRadius: -DefaultProperty.instance.sizes.defaultFontSize
          ),
        ],
      ),
      child: DropdownButtonFormField(
        isDense: true,
        items: dropdownStringItems.map((e){
          return DropdownMenuItem(
            value: e,
            child: TextWidget(
              text: e,
              family: "Avenir",
              color: foregroundColor,
              size: 16,
              lineHeight: DefaultProperty.instance.spacing.letterSpacingToCenter,
            )
          );
        }).toList(),
        decoration: InputDecoration(
          errorStyle: TextStyle(
              height: 0.5,
              color: Colors.red[700]
          ),
          contentPadding: EdgeInsets.only(
              left:DefaultProperty.instance.sizes.defaultFontSize,
              bottom:DefaultProperty.instance.sizes.defaultFontSize,
              top:DefaultProperty.instance.sizes.defaultFontSize,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  DefaultProperty.instance.spacing.inputBorderRadius
              ),
              borderSide: BorderSide(
                  color: Colors.grey,
                  strokeAlign: StrokeAlign.inside
              )
          ),
          isDense: true,
          prefixIconConstraints: const BoxConstraints(),
          suffixIconConstraints: const BoxConstraints(),
          hintText: text,
          hintStyle: TextStyle(
            color: Color.lerp(foregroundColor, backgroundColor, 0.5),
          ),
          prefixIcon: prefixIcon == null ? null : Padding(
            padding: EdgeInsets.symmetric(
                horizontal: DefaultProperty.instance.spacing.defaultPaddingInputSize
            ),
            child: Icon(
              prefixIcon,
              size: buttonSize,
              color: iconColor,
            ),
          ),
          filled: true,
          fillColor: backgroundColor,
        ),
        iconSize: fontSize,
        icon: Icon(
          Icons.arrow_drop_down,
          size: buttonSize,
          color: iconColor,
        ),
        validator: (value) {
          if(required){
            if(value==null){
              return "Not a valid option";
            }
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.always,
        onChanged: (value){
          action;
          actualValue=value;
        },
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        focusNode: focusNode,
      )
    );
  }
}
