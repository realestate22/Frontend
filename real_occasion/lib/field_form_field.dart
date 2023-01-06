

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_occasion/services/cloud.dart';

class FieldFormField extends StatefulWidget {
  String type;
  String label;
  String? regex;
  bool suffix;
  FocusNode currFN;
  FocusNode? nextFN;
  TextEditingController currTEC;
  double fontSize;
  String? optRegexMessage;
  SelectFormField? idFrom;
  double? width;

  FieldFormField({
    required this.type,
    required this.label,
    required this.currFN,
    required this.currTEC,
    this.regex,
    this.nextFN,
    this.idFrom,
    this.width,
    this.suffix = true,
    this.fontSize = 16,
    this.optRegexMessage,
  });

  @override
  State<FieldFormField> createState() => _FieldFormFieldState();
}

class _FieldFormFieldState extends State<FieldFormField> {

  bool _visible=true;
  StreamSubscription<DatabaseEvent>? dbListener;


  @override
  void initState() {
    if(widget.label=="password"){
      _visible=false;
    }

    if(widget.idFrom!=null){
      widget.idFrom!.valueSubscription.listen((event) {
        FirebaseDatabase fbdb = Provider.of<FireBaseClient>(context, listen: false).firebaseDatabase;
        DatabaseReference dbr = fbdb.ref("test/$event/${widget.label}");
         dbListener = dbr.onValue.listen((DatabaseEvent event) {
          setState(() {
            widget.currTEC.text=event.snapshot.value.toString() ?? "";
          });
        });

      });
    }



  }
  @override
  void dispose() {
    dbListener?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (widget.type == "text") {
      if(widget.label == "email"){
        return SizedBox(
          width: widget.width,
          child: TextFormField(
            focusNode: widget.currFN,
            controller: widget.currTEC,
            decoration: InputDecoration(
                labelText: "${capitalize(widget.label)}:"
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.always,
            validator: (value) {
              if(value==null||value==""){
                return "Enter ${widget.label}";
              }
              if(widget.regex!=null) {
                if (!value.contains(RegExp(widget.regex.toString()))) {
                  return widget.optRegexMessage ?? "Not a correct ${widget.label} pattern";
                }
              }
              return null;
            },
            style: TextStyle(
              fontSize: widget.fontSize,
            ),
            onEditingComplete: () => widget.nextFN?.requestFocus(),
          ),
        );
      }else if(widget.label == "password"){
        return Container(
          width: widget.width,
          child: TextFormField(
            focusNode: widget.currFN,
            controller: widget.currTEC,
            decoration: InputDecoration(
              labelText: "${capitalize(widget.label)}:",
              suffixIcon: widget.suffix
                ? IconButton(
                  onPressed: ()=>setState(()=>_visible=!_visible),
                  icon: Icon(
                    _visible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  )
                )
                : Container(),
            ),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.always,
            obscureText: !_visible,
            validator: (value) {
              if(value==null||value==""){
                return "Enter ${widget.label}";
              }
              if(widget.regex!=null) {
                if (!value.contains(RegExp(widget.regex.toString()))) {
                  return widget.optRegexMessage ?? "Not a correct ${widget.label} pattern";
                }
              }
              return null;
            },
            style: TextStyle(
              fontSize: widget.fontSize,
            ),
            onEditingComplete: () => widget.nextFN?.requestFocus(),
          ),
        );
      }
      return Container(
        width: widget.width,
        child: TextFormField(
          focusNode: widget.currFN,
          controller: widget.currTEC,
          decoration: InputDecoration(
              labelText: "${capitalize(widget.label)}:"
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if(value==null||value==""){
              return "Enter ${widget.label}";
            }
            if(widget.regex!=null) {
              if (!value.contains(RegExp(widget.regex.toString()))) {
                return widget.optRegexMessage ?? "Not a correct ${widget.label} pattern";
              }
            }
            return null;
          },
          style: TextStyle(
            fontSize: widget.fontSize,
          ),
          onEditingComplete: () => widget.nextFN?.requestFocus(),
        ),
      );
    }
    else if(widget.type=="number"){
      return Container(
        width: widget.width,
        child: TextFormField(
          focusNode: widget.currFN,
          controller: widget.currTEC,
          decoration: InputDecoration(
              labelText: "${capitalize(widget.label)}:"
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if(value==null||value==""){
              return "Enter ${widget.label}";
            }
            if(double.tryParse(value)==null){
              return "The value given is not a number";
            }
            if(widget.regex!=null) {
              if (!value.contains(RegExp(widget.regex.toString()))) {
                return widget.optRegexMessage ?? "Not a correct ${widget.label} pattern";
              }
            }
            return null;
          },
          style: TextStyle(
            fontSize: widget.fontSize,
          ),
          onEditingComplete: () => widget.nextFN?.requestFocus(),
        ),
      );
    }
    else {
      return Container();
    }
  }

  String? capitalize(String? input){
    return input==null ? null :
      input.isEmpty ? "" :
      input.length == 1 ? input.toUpperCase() :
      input[0].toUpperCase()+input.substring(1);
  }
}



class SelectFormField extends StatefulWidget{

  String label;
  FocusNode currFN;
  FocusNode? nextFN;
  double fontSize;
  String? value ;
  List<String>? items;
  double? width;

  late StreamController<String> sc;
  late Stream<String> valueSubscription;

  SelectFormField({
    required this.label,
    required this.currFN,
    this.nextFN,
    this.fontSize = 16,
    this.value,
    this.items,
    this.width
  }){
    sc=StreamController<String>.broadcast();
    valueSubscription = sc.stream;
    valueSubscription.listen((event) {
      print(event);
    });
  }






  @override
  State<SelectFormField> createState() => _SelectFormFieldState();


}

class _SelectFormFieldState extends State<SelectFormField> {
  late StreamSubscription<DatabaseEvent> listenerSelectionKeys;

  @override
  void initState() {
    super.initState();
    FirebaseDatabase fbdb = Provider.of<FireBaseClient>(context, listen: false).firebaseDatabase;
    DatabaseReference dbr = fbdb.ref("test/");

    Stream<DatabaseEvent> stream = dbr.onValue;
// Subscribe to the stream!
    listenerSelectionKeys=stream.listen((DatabaseEvent event) async {
      // print('Event Type: ${event.type}'); // DatabaseEventType.value;
      // print('Snapshot: ${await event.snapshot.key}');
      // print('Items: ${await event.snapshot.children.map((e) => {e.key : e.value})}'); // DataSnapshot
      updateSelect(event.snapshot.children.map((e) => e.key!).toList(), context);
      //print(_editSelectId.items);
      print(widget.items);
    });
  }
  @override
  void dispose() {
    listenerSelectionKeys.cancel();
    super.dispose();
  }

  updateSelect(List<String>? newItems, BuildContext bc){

    if(newItems !=null) {
      updateValue(newItems.first, bc);
      updateItems(newItems);
    }
    //print(items);

  }
  updateValue(String newValue, BuildContext bc){
    if(widget.value==null){
      widget.value=newValue;
      widget.sc.add(newValue);
    }else {
      if(widget.value!=newValue){
        widget.value=newValue;
        widget.sc.add(newValue);
      }
    }
    setState(() {

    });
  }


  updateItems(List<String> newItems){
    if(widget.items==null){
      widget.items=newItems;
    }else{
      if(widget.items!.length!=newItems.length){
        widget.items=newItems;
      }else{
        bool checkEquality=true;
        for(int i = 0; i < newItems.length; i++){
          if(widget.items![i]!=newItems[i]){
            checkEquality=false;
            break;
          }
        }
        if(!checkEquality){
          widget.items=newItems;
        }
      }
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {

      return Container(
        width: widget.width,
        child: DropdownButtonFormField(
            value: widget.value,
            focusNode: widget.currFN,
            items:
              widget.items?.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
          onTap: () {
              if(widget.items!=null) {
                setState(() {
                  print(widget.items);
                });
              }
            },
            onChanged: (value) {
              setState(() {
                updateValue(value!, context);
              });
            },
        ),
      );
  }
}

