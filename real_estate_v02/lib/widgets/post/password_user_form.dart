import 'dart:developer';

import 'package:flutter/material.dart';

import '../default_property.dart';
import 'icon_change.dart';

class PasswordUserForm extends StatefulWidget {
  VoidCallback action;
  IconData? prefixIcon;
  late IconChange iconChange;
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
  TextEditingController? _matchTec;
  bool totalValidation = false;


  set matchTec(TextEditingController value) {
    _matchTec = value;
    textEditCon.addListener(() {_matchTec?.notifyListeners();});
  }

  PasswordUserForm({
    this.width,
    this.prefixIcon,
    IconChange? iconChange,
    this.buttonSize,
    required this.placeholder,
    required this.action,
    double? fontSize,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black,
    Color? iconColor,
    this.validate = const{
      "^[a-zA-Z0-9!@#\$%^&*_+=\\-/ ]{8,34}\$": "Not a valid password!"
    },
    this.validateAuto = const{
      "^[a-zA-Z0-9!@#\$%^&*_+=\\-/ ]*\$": "Not valid characters!"
    },
    this.required = true,
  }) {
    this.fontSize = fontSize ?? DefaultProperty.instance.sizes.defaultFontSize;
    this.iconColor = iconColor ?? foregroundColor;
    focusNode = FocusNode();
    textEditCon = TextEditingController();
  }

  @override
  State<PasswordUserForm> createState() => _PasswordUserFormState();

  void addControllerToMatchTo(TextEditingController matchTec) {
    this.matchTec=matchTec;
  }

  bool isValidated(){
    totalValidation=true;
    if(_matchTec!=null){
      if(textEditCon.text==null){
        return false;
      }

      return textEditCon.text==_matchTec!.text;
    }
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
}

class _PasswordUserFormState extends State<PasswordUserForm> {
  bool shown = false;

  @override
  Widget build(BuildContext context) {
    widget.iconChange = IconChange(
      shown: shown,
      iconSize: widget.buttonSize,
      shownData: Icons.visibility,
      notShownData: Icons.visibility_off,
      shownColor: Color.lerp(widget.foregroundColor, widget.backgroundColor, 0.5)!,
      action: () {
        setState(() {
          shown=!shown;
        });
      },
    );
    log('password_built');

    return Container(
      height: DefaultProperty.instance.sizes.defaultFontSize *
          (widget.required ? 5 : 4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: DefaultProperty.instance.sizes.defaultFontSize,
              offset: Offset(0, (widget.required ? -1 : 1) *
                  DefaultProperty.instance.sizes.defaultFontSize/2),
              color: Color.fromRGBO(0,0,0,0.1),
              spreadRadius: -DefaultProperty.instance.sizes.defaultFontSize
          ),
        ],
      ),
      child: TextFormField(

        controller: widget.textEditCon,
        focusNode: widget.focusNode,
        style: TextStyle(
          fontFamily: "Avenir",
          fontSize: widget.fontSize,
          color: widget.foregroundColor,
          height: DefaultProperty.instance.spacing.letterSpacingToCenter
        ),
        obscureText: !shown,
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
          hintText: widget.placeholder,
          hintStyle: TextStyle(
            color: Color.lerp(widget.foregroundColor, widget.backgroundColor, 0.5),
          ),
          prefixIcon: widget.prefixIcon == null ? null : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DefaultProperty.instance.spacing.defaultPaddingInputSize
            ),
            child: Icon(
              widget.prefixIcon,
              size: widget.buttonSize,
              color: widget.iconColor,
            ),
          ),
          suffixIcon: widget.iconChange,
          filled: true,
          fillColor: widget.backgroundColor,
        ),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (widget.required) {
            if(widget._matchTec!=null){
              if (value != widget._matchTec!.text){
                return "Value not matching other field";
              }
            }
            for (MapEntry<String,String> element in widget.validateAuto.entries) {
              if(value!=null && value.isNotEmpty) {
                if (!value.contains(RegExp(element.key))) {
                  return element.value;
                }
              }
            }
            if(widget.totalValidation){
              if(value!.isEmpty){
                return "${widget.placeholder} is empty";
              }
              for (MapEntry<String,String> element in widget.validate.entries) {
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
        onEditingComplete: widget.action,
        textInputAction: TextInputAction.next,
      )
    );
  }
}

