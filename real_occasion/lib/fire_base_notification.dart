import 'package:flutter/material.dart';

import 'field_form_field.dart';

class FireBaseNotification extends StatefulWidget {

  @override
  State<FireBaseNotification> createState() => _NotificationState();
}

class _NotificationState extends State<FireBaseNotification> {
  GlobalKey<FormState> _form=GlobalKey();
  FocusNode _titleFN = FocusNode();
  TextEditingController _titleTEC = TextEditingController();
  FocusNode _descFN = FocusNode();
  TextEditingController _descTEC = TextEditingController();
  FocusNode _delayFN = FocusNode();
  TextEditingController _delayTEC = TextEditingController();
  FocusNode _notify = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                  nextFN: _descFN,
                ),
                FieldFormField(
                  type: "text",
                  label: "description",
                  currFN: _descFN,
                  currTEC: _descTEC,
                  nextFN: _delayFN,
                ),
                FieldFormField(
                  type: "number",
                  label: "delay",
                  currFN: _delayFN,
                  currTEC: _delayTEC,
                  nextFN: _notify,
                ),
                TextButton(
                  focusNode: _notify,
                  onPressed: (){
                    if(_form.currentState!.validate()){

                    }
                  },
                  child: Text("Notify")
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
