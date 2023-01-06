import 'dart:async';

import 'dart:developer';
import 'dart:math' as Math;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_v02/models/item_model.dart';
import 'package:real_estate_v02/provider/item_provider.dart';
import 'package:real_estate_v02/provider/screen_controller.dart';
import 'package:real_estate_v02/services/firebase_rtdb.dart';
import 'package:real_estate_v02/services/internet_connection.dart';
import 'package:real_estate_v02/services/permission_handler.dart';
import 'package:real_estate_v02/widgets/data_handler_widget.dart';
import 'package:real_estate_v02/widgets/default_property.dart';
import 'package:real_estate_v02/widgets/hero_dialog_route.dart';
import 'package:real_estate_v02/widgets/modal_widget.dart';
import 'package:real_estate_v02/widgets/post/submit_user_form.dart';
import 'package:real_estate_v02/widgets/text_widget.dart';
import 'provider/home_filter_controller.dart';
import 'widgets/screen_changer.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  PermissionHandler.instance.handlePermission();
  Firebase.initializeApp();
  InternetConnection.instance;
  runApp(
    MaterialApp(
      home:
      MyApp()
        //TestApp()
    )
  );
}

class MyApp extends StatelessWidget {
  late ItemProvider itemProvider;

  MyApp(){
    FirebaseRTDB.instance.setUpDummyData();
    itemProvider=ItemProvider(
      allItems: {}..addEntries(
          FirebaseRTDB.instance.dummyData["items"]!.map((e) {
            return MapEntry((e as ItemModel).id, (e as ItemModel).bookmarked);
          },
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<ScreenController>(create: (_)=>ScreenController(initialPage: 0)),
            ChangeNotifierProvider<HomeFilterController>(create: (_) => HomeFilterController()),
            ChangeNotifierProvider<ItemProvider>(create: (_) => itemProvider),
          ],
          child: ScreenChanger(),
        );
      },
    );
  }
}

class TestApp extends StatelessWidget {
  TestApp(){

  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        log("Max height: ${constraint.maxHeight}, Max width: ${constraint.maxWidth}\n"+
          "Rect ${Math.Rectangle(
              0,  DefaultProperty.instance.sizes.logoDisplaySize
              + DefaultProperty.instance.sizes.registerHeight,
              constraint.maxWidth, constraint.maxHeight
              - DefaultProperty.instance.spacing.sideMargins * 5
              - DefaultProperty.instance.sizes.logoDisplaySize
              - DefaultProperty.instance.sizes.registerHeight)}"
        );
        return Scaffold(
          backgroundColor: Colors.lightBlue,
          body: ListView(
            children: [
              SubmitUserForm(text: "Open", action: (){
                ModalWidget.callModalWidget(context, ModalWidget(
                  size: Size(constraint.maxWidth,constraint.maxHeight
                      - DefaultProperty.instance.spacing.sideMargins * 5
                      - DefaultProperty.instance.sizes.logoDisplaySize
                      - DefaultProperty.instance.sizes.registerHeight),
                  position: Math.Point<double>(0,
                          DefaultProperty.instance.sizes.logoDisplaySize
                          + DefaultProperty.instance.sizes.registerHeight),
                  boxDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                      child: TextWidget(text: "Contained")
                  ),
                ));
              }),
            ],
          )
        );
      },
    );
  }
  _displayPopUp(BuildContext context, String text){
    showModalBottomSheet(context: context, builder: (context) {
      return LayoutBuilder(
        builder: (context, constraint) {
          return Container(
            height: constraint.maxHeight/2,
            child: Text(
              text
            ),
          );
        },
      );
    });
  }
}

