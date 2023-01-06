import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_occasion/field_form_field.dart';
import 'package:real_occasion/services/cloud.dart';

class FireBaseRealDB extends StatefulWidget {

  @override
  State<FireBaseRealDB> createState() => _FireBaseRealDBState();
}

class _FireBaseRealDBState extends State<FireBaseRealDB> {
  GlobalKey<FormState> _form= GlobalKey<FormState>();
  FocusNode _titleFN = FocusNode();
  TextEditingController _titleTEC = TextEditingController();
  FocusNode _longFN = FocusNode();
  TextEditingController _longTEC = TextEditingController();
  FocusNode _latFN = FocusNode();
  TextEditingController _latTEC = TextEditingController();
  FocusNode _postFN = FocusNode();

  GlobalKey<FormState> _editForm= GlobalKey<FormState>();
  FocusNode _editSelectedIdFN = FocusNode();

  FocusNode _editTitleFN = FocusNode();
  TextEditingController _editTitleTEC = TextEditingController();
  FocusNode _editLongFN = FocusNode();
  TextEditingController _editLongTEC = TextEditingController();
  FocusNode _editLatFN = FocusNode();
  TextEditingController _editLatTEC = TextEditingController();
  FocusNode _editPostFN = FocusNode();
  late List<FieldFormField> _editFields;
  late SelectFormField _editSelectId;

  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    _editSelectId = SelectFormField(
    label: "id",
    currFN: _editSelectedIdFN,
    nextFN: _editTitleFN,
    );



    _editFields=[
      FieldFormField(
        type: "text",
        label: "title",
        currFN: _editTitleFN,
        currTEC: _editTitleTEC,
        nextFN: _editLongFN,
        idFrom: _editSelectId,
      ),
      FieldFormField(
        type: "number",
        label: "longitude",
        currFN: _editLongFN,
        currTEC: _editLongTEC,
        nextFN: _editLatFN,
        idFrom: _editSelectId,
      ),
      FieldFormField(
        type: "number",
        label: "latitude",
        currFN: _editLatFN,
        currTEC: _editLatTEC,
        nextFN: _editPostFN,
        idFrom: _editSelectId,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView(
          children: [
            Form(
              key: _form,
              child: Column(
                children: [
                  FieldFormField(
                      type: "text",
                      label: "title",
                      currFN: _titleFN,
                      currTEC: _titleTEC,
                      nextFN: _longFN,
                  ),
                  FieldFormField(
                      type: "number",
                      label: "longitude",
                      currFN: _longFN,
                      currTEC: _longTEC,
                      nextFN: _latFN,
                  ),
                  FieldFormField(
                    type: "number",
                    label: "latitude",
                    currFN: _latFN,
                    currTEC: _latTEC,
                    nextFN: _postFN,
                  ),
                  TextButton(
                    focusNode: _postFN,
                      onPressed: (){
                        if(_form.currentState!.validate()){
                          _titleFN.unfocus();
                          _latFN.unfocus();
                          _longFN.unfocus();
                          _postFN.unfocus();

                          FirebaseDatabase fbdb = Provider.of<FireBaseClient>(context, listen: false).firebaseDatabase;
                          DatabaseReference dbr = fbdb.ref("test/");
                          dbr.push().set({
                            "title": _titleTEC.text,
                            "longitude": _longTEC.text,
                            "latitude": _latTEC.text
                          });
                        }
                      },
                      child: Text("Post")
                  ),
                ],
              ),
            ),
            Form(
              key: _editForm,
              child: Column(
                children: [
                  _editSelectId ,
                  ..._editFields,
                  TextButton(
                      focusNode: _editPostFN,
                      onPressed: (){
                        if(_editForm.currentState!.validate()){
                          _editSelectedIdFN.unfocus();
                          _editTitleFN.unfocus();
                          _editLongFN.unfocus();
                          _editLatFN.unfocus();
                          _editPostFN.unfocus();

                          FirebaseDatabase fbdb = Provider.of<FireBaseClient>(context, listen: false).firebaseDatabase;
                          DatabaseReference dbr = fbdb.ref("test/${_editSelectId.value}/");
                          dbr.update({
                            "title": _editTitleTEC.text,
                            "longitude": _editLongTEC.text,
                            "latitude": _editLatTEC.text
                          });
                        }
                      },

                      child: Text("Update")
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }


}


