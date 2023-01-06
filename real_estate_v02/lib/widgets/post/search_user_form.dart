import 'dart:developer';

import 'package:flutter/material.dart';

import '../default_property.dart';
import 'icon_change.dart';

class SearchUserForm extends StatelessWidget {
  VoidCallback action;
  IconData? prefixIcon;
  IconChange? iconChange;
  late double fontSize;
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
  double? width;

  bool totalValidation = false;

  SearchUserForm({
    this.width,
    this.prefixIcon,
    required this.iconChange,
    this.buttonSize,
    required this.placeholder,
    required this.action,
    double? fontSize,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black,
    Color? iconColor,
    this.validate = const{},
    this.validateAuto = const{},
    this.required = false,
    TextEditingController? editCon,
  }) {
    this.fontSize = fontSize ?? DefaultProperty.instance.sizes.defaultFontSize;
    this.iconColor = iconColor ?? foregroundColor;

    textEditCon = editCon ?? TextEditingController();
    focusNode = FocusNode();
  }

  bool isValidated(){
    totalValidation = false;
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
    log('search_built');
    return Container(
      height: DefaultProperty.instance.sizes.defaultFontSize *
          (required ? 5 : 4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: DefaultProperty.instance.sizes.defaultFontSize,
              offset: Offset(0, (required ? -1 : 1) *
                  DefaultProperty.instance.sizes.defaultFontSize/2
              ),
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
          suffixIconConstraints: BoxConstraints(),
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
          suffixIcon: iconChange,
          filled: true,
          fillColor: backgroundColor,
        ),
        keyboardType: TextInputType.text,
        validator: (value) {
          if(required){
            String? errorMessage;
            for (MapEntry<String,String> element in validateAuto.entries) {
              if(value!=null && value.isNotEmpty) {
                if (!value.contains(RegExp(element.key))) {
                  errorMessage = element.value;
                  break;
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