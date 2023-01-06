import 'package:flutter/material.dart';
import 'package:real_estate_v02/widgets/default_property.dart';

class PostScreen extends StatefulWidget {

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: DefaultProperty.instance.colors.backgroundColor,
        body: Container()
      ),
    );
  }
}
