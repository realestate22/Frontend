import 'package:flutter/material.dart';

class Account extends StatefulWidget {

  VoidCallback? refresh;
  Account({this.refresh}){

  }

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
    );
  }
}
