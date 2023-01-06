import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:real_occasion/services/cloud.dart';
import 'package:real_occasion/field_form_field.dart';

class FireBaseAuth extends StatefulWidget {
  @override
  State<FireBaseAuth> createState() => _FireBaseAuthState();
}

class _FireBaseAuthState extends State<FireBaseAuth> {
  TextEditingController _emailRegister = TextEditingController() ;
  TextEditingController _passwordRegister = TextEditingController();
  FocusNode _emailFieldRegister = FocusNode();
  FocusNode _passwordFieldRegister = FocusNode();
  FocusNode _submitFieldRegister = FocusNode();
  GlobalKey<FormState> _formKeyRegister = GlobalKey<FormState>();
  bool _enabledSubmitRegister = true;

  TextEditingController _emailSign = TextEditingController() ;
  TextEditingController _passwordSign = TextEditingController();
  FocusNode _emailFieldSign = FocusNode();
  FocusNode _passwordFieldSign = FocusNode();
  FocusNode _submitFieldSign = FocusNode();
  GlobalKey<FormState> _formKeySign = GlobalKey<FormState>();
  bool _enabledSubmitSign = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: ListView(
        children: [
          Form(
            key: _formKeyRegister,
            child: Column(
              children: [
                FieldFormField(
                  type: "text",
                  label: "email",
                  currFN: _emailFieldRegister,
                  currTEC: _emailRegister,
                  nextFN: _passwordFieldRegister,
                  regex: "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$",
                ),
                FieldFormField(
                  type: "text",
                  label: "password",
                  currFN: _passwordFieldRegister,
                  currTEC: _passwordRegister,
                  nextFN: _submitFieldRegister,
                  regex: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$",
                  optRegexMessage: "Password must contain eight characters, at least one letter and one number",
                ),
                TextButton(
                  focusNode: _submitFieldRegister,
                  onPressed: _enabledSubmitRegister?() {
                    if(_formKeyRegister.currentState!.validate()){
                      print("Email: ${_emailRegister.text}, Password: ${_passwordRegister.text}");
                      context.read<FireBaseClient>().registerEmail(
                          _emailRegister.text, _passwordRegister.text);

                      _emailFieldRegister.unfocus();
                      _passwordFieldRegister.unfocus();
                      _submitFieldRegister.unfocus();

                      if(_enabledSubmitRegister){
                        setState( () => _enabledSubmitRegister = false );
                        Timer( Duration (seconds: 5),
                          () => setState(() => _enabledSubmitRegister = true )
                        );
                      }
                    }else{
                      print("Error");
                    }
                  }:null,
                  child: Text("Register"),
                ),
              ]
            )
          ),
          Form(
            key: _formKeySign,
            child: Column(
              children: [
                FieldFormField(
                  type: "text",
                  label: "email",
                  currFN: _emailFieldSign,
                  currTEC: _emailSign,
                  nextFN: _passwordFieldSign,
                  regex: "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$",
                ),
                FieldFormField(
                  type: "text",
                  label: "password",
                  currFN: _passwordFieldSign,
                  currTEC: _passwordSign,
                  nextFN: _submitFieldSign,
                  regex: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$",
                  optRegexMessage: "Password must contain eight characters, at least one letter and one number",
                ),
                TextButton(
                  focusNode: _submitFieldSign,
                  onPressed: _enabledSubmitSign?() {
                    if(_formKeySign.currentState!.validate()){
                      print("Email: ${_emailSign.text}, Password: ${_passwordSign.text}");
                      context.read<FireBaseClient>().signInWithEmail(
                          _emailSign.text,  _passwordSign.text);

                      _emailFieldSign.unfocus();
                      _passwordFieldSign.unfocus();
                      _submitFieldSign.unfocus();

                      if(_enabledSubmitSign){
                        setState( () => _enabledSubmitSign = false );
                        Timer( Duration (seconds: 5),
                            () => setState(() => _enabledSubmitSign = true )
                        );
                      }
                    }else{
                      print("Error");
                    }
                  }:null,
                  child: Text("Sign in"),
                ),
              ]
            )
          ),
          TextButton.icon(
            onPressed: (){
              context.read<FireBaseClient>().signInWithGoogle();
            },
            icon: FaIcon(FontAwesomeIcons.google),
            label: Text("Sign up with Google"),
          ),
          TextButton.icon(
            onPressed: (){
              context.read<FireBaseClient>().logOut();
            },
            icon: FaIcon(FontAwesomeIcons.rightFromBracket),
            label: Text("Logout"),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Text(
                  "User",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "${context.watch<FireBaseClient>().actualUser?.user}",
                )
              ],
            )
          )
        ],
      )
    );
  }
}
