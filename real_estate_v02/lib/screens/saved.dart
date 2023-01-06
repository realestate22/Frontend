import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item_model.dart';
import '../provider/item_provider.dart';
import '../services/firebase_rtdb.dart';
import '../widgets/default_property.dart';
import '../widgets/home/item_widget.dart';

class SavedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultProperty.instance.colors.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraint) {
          return FutureBuilder(
            builder: (context, snapshot) {
              return Container(
                width: constraint.maxWidth,
                margin: EdgeInsets.only(
                  left: DefaultProperty.instance.spacing.sideMargins,
                  right: DefaultProperty.instance.spacing.sideMargins,
                  top: DefaultProperty.instance.spacing.sideMargins * 2 +
                      DefaultProperty.instance.sizes.searchHeight,
                ),
                child: FirebaseRTDB.instance.dummyData["items"] == null
                ? SizedBox(
                  height: DefaultProperty.instance.spacing.sideMargins +
                      DefaultProperty.instance.sizes.navigationHeight
                )
                : Consumer<ItemProvider>(
                  builder: (context, value, child) {
                    List<ItemModel> bookmarked =
                      FirebaseRTDB.instance.dummyData["items"]!.where(
                        (element) {
                          return value.getBookmarkedItemIDs().contains(
                            (element as ItemModel).id
                          );
                        }
                      ).map((e) => e as ItemModel).toList();
                    return ListView.builder(
                      itemCount:bookmarked.length+1,
                      itemBuilder: (context, index) {
                        if(index==bookmarked.length){
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
                            itemModel: bookmarked[index]
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
