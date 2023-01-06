import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:real_estate_v02/widgets/home/search_bar.dart';

import '../models/item_model.dart';
import '../services/firebase_rtdb.dart';
import '../widgets/account/register.dart';
import '../widgets/account/sign_up.dart';
import '../widgets/default_property.dart';
import '../widgets/home/item_widget.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraint) {
          return GestureDetector(
            onTap: (){
              FocusScopeNode currentFocus = FocusScope.of(context);
              currentFocus.unfocus();
            },
            child: Scaffold(
              backgroundColor: DefaultProperty.instance.colors.backgroundColor,
              body: Stack(
                children: [
                  FutureBuilder(
                    builder: (context, snapshot) {
                      return Container(
                        width: constraint.maxWidth,
                        margin: EdgeInsets.only(
                          left: DefaultProperty.instance.spacing.sideMargins,
                          right: DefaultProperty.instance.spacing.sideMargins,
                          top: DefaultProperty.instance.spacing.sideMargins +
                              DefaultProperty.instance.sizes.defaultFontSize * 4,
                        ),
                        child: FirebaseRTDB.instance.dummyData["items"] == null
                          ? SizedBox(
                            height: DefaultProperty.instance.spacing.sideMargins +
                              DefaultProperty.instance.sizes.navigationHeight
                          )
                          : ListView.builder(
                          itemCount: FirebaseRTDB.instance.dummyData["items"]!.length + 1,
                          itemBuilder: (context, index) {
                            if (index == FirebaseRTDB.instance.dummyData["items"]!.length) {
                              return SizedBox(
                                  height: DefaultProperty.instance.spacing.sideMargins +
                                      DefaultProperty.instance.sizes.navigationHeight
                              );
                            }
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: DefaultProperty.instance.spacing.spaceBetween
                              ),
                              height: DefaultProperty.instance.sizes.itemWidgetHeight,
                              child: ItemWidget(
                                itemModel: (
                                  FirebaseRTDB.instance.dummyData["items"]![index] as ItemModel
                                )
                              )
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Container(
                    child: SearchBar(),
                  )
                ],
              ),
            ),
          );
        }
    );

  }
}
