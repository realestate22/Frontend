import 'package:flutter/material.dart';
import 'package:real_estate_v02/widgets/home/search_bar.dart';

import '../../models/item_model.dart';
import '../../services/firebase_rtdb.dart';
import '../default_property.dart';
import 'item_widget.dart';

class ItemList extends StatefulWidget {
  BoxConstraints constraint;
  ItemList(this.constraint){}

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  @override
  Widget build(BuildContext context) {

        return Container(
          width: widget.constraint.maxWidth,
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
  }
}
