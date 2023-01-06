import 'dart:developer';

import 'package:flutter/material.dart';

import '../default_property.dart';

class NumberUserForm extends StatelessWidget {
  VoidCallback action;
  IconData? prefixIcon;
  late double fontSize;
  double? width;
  double? buttonSize;
  String placeholder;
  Color backgroundColor;
  Color foregroundColor;
  late Color iconColor;
  late FocusNode focusNode;
  late TextEditingController textEditCon;
  Map<String, String> validate;
  Map<String, String> validateAuto;
  bool required;
  bool totalValidation = false;

  NumberUserForm({
    this.prefixIcon,
    this.buttonSize,
    required this.placeholder,
    required this.action,
    double? fontSize,
    this.backgroundColor=Colors.white,
    this.foregroundColor=Colors.black,
    Color? iconColor,
    this.validate= const{
      "^[0-9]+([.][0-9]+)?\$": "Not a valid number!"
    },
    this.validateAuto=const{
      "^[.0-9]*\$" : "Not appropriate characters",
      "^[^.]*.?[^.]*\$" : "There shouldn't be two '.'",
      "^([^.].*[^.]|[^.])\$":"'.' shouldn't be in first or last position",
    },
    this.required = true,
  }){
    this.fontSize = fontSize ?? DefaultProperty.instance.sizes.defaultFontSize;
    this.iconColor = iconColor ?? foregroundColor;
    focusNode=FocusNode();
    textEditCon=TextEditingController();
  }

  bool isValidated(){
    totalValidation=true;
    if(required){
      if(textEditCon.text==null){
        return false;
      }
      bool hasError=false;
      for (MapEntry<String,String> element in validate.entries) {
        if(!textEditCon.text.contains(RegExp(element.key))){
          hasError=true;
          break;
        }
      }
      return !hasError;
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    log('number_built');
    return Container(
      height: DefaultProperty.instance.sizes.defaultFontSize * (required ? 5 : 4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: DefaultProperty.instance.sizes.defaultFontSize,
              offset: Offset(0, (required ? -1 : 1) *
                  DefaultProperty.instance.sizes.defaultFontSize/2),
              color: Color.fromRGBO(0,0,0,0.1),
              spreadRadius: -DefaultProperty.instance.sizes.defaultFontSize
          ),
        ],
      ),
      child: TextFormField(
        controller: textEditCon,
        focusNode: focusNode,
        style: TextStyle(
          fontFamily: "Avenir",
          fontSize: fontSize,
          color: foregroundColor,
          height: DefaultProperty.instance.spacing.letterSpacingToCenter
        ),
        decoration: InputDecoration(

          errorStyle: TextStyle(
              height: 0.5,
              color: Colors.red[700]
          ),
          contentPadding: EdgeInsets.all(
              DefaultProperty.instance.spacing.defaultPaddingInputSize
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
          prefixIconConstraints: BoxConstraints(),
          hintText: placeholder,
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
        keyboardType: TextInputType.number,
        validator: (value) {
          if(required){
            for (MapEntry<String,String> element in validateAuto.entries) {
              if(value!=null && value.isNotEmpty) {
                if (!value.contains(RegExp(element.key))) {
                  return element.value;
                }
              }
            }
            if(totalValidation){
              if(value!.isEmpty){
                return "$placeholder is empty";
              }
              for (MapEntry<String,String> element in validate.entries) {
                if(value!=null && value.isNotEmpty) {
                  if (!value.contains(RegExp(element.key))) {
                    return element.value;
                  }
                }
              }
            }
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.always,
        onEditingComplete: action,
        textInputAction: TextInputAction.next,
      )
    );
  }
}