import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_v02/provider/item_provider.dart';
import 'package:real_estate_v02/widgets/default_property.dart';
import '../../models/item_model.dart';
import '../map_display.dart';
import '../text_widget.dart';
import 'gallery_scroll_viewer.dart';
import 'item_detailed.dart';

class ItemWidget extends StatefulWidget {
  ItemModel itemModel;
  ItemDetailed? itemDetailed;

  late GalleryScrollViewer gsv;
  late UniqueKey uk;

  ItemWidget({required this.itemModel}){
    gsv=GalleryScrollViewer(
      gallery: [
        itemModel.wallpaper,
        ...itemModel.photo_gallery,
      ]
    );
    uk=UniqueKey();
    itemDetailed=ItemDetailed(itemModel: itemModel, gsv: gsv, tag: uk);
  }

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {


  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context){
                  return widget.itemDetailed!;
                }
              ),
            );
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(DefaultProperty.instance.spacing.borderRadius)
              )
            ),
            child: Stack(
              children: [
                Hero(
                  tag: widget.uk,
                  child: Container(
                    width: constraint.maxWidth,
                    height: DefaultProperty.instance.sizes.itemViewHeight,
                    child: widget.gsv,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(DefaultProperty.instance.spacing.sideMargins),
                  width: constraint.maxWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                          widget.itemModel.tags.length,
                          (index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical:DefaultProperty.instance.spacing.sideTextPadding,
                                  horizontal: DefaultProperty.instance.spacing.sideTextPadding * 2,
                              ),
                              margin: EdgeInsets.only(
                                  right: DefaultProperty.instance.spacing.sideTextPadding),
                              child: TextWidget(
                                text: widget.itemModel.tags[index]["name"] ?? "Error",
                                color: DefaultProperty.instance.colors.lightColor,
                                size: 12,
                              ),
                              decoration: BoxDecoration(
                                color: DefaultProperty.instance.colors.blackTransparent,
                                borderRadius: BorderRadius.circular(
                                    DefaultProperty.instance.spacing.borderRadius
                                ),
                              ),
                            );
                          }
                        ),
                      ),
                      Consumer<ItemProvider>(
                        builder: (context, value, child) {
                          return IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              widget.itemModel.setBookMarked(!widget.itemModel.getBookMarked());
                              value.update(widget.itemModel.id);
                            },
                            icon: DecoratedIcon(
                              icon: Icon(
                                Icons.bookmark,
                                color: (value.allItems[widget.itemModel.id]!) ?
                                DefaultProperty.instance.colors.redContrast :
                                Colors.transparent
                              ),
                              decoration: IconDecoration(
                                border: IconBorder(
                                  color: Colors.white,
                                  width: (value.allItems[widget.itemModel.id]!) ? 3 : 2
                                ),
                                shadows: (value.allItems[widget.itemModel.id]!) ?
                                [
                                  Shadow(
                                    color: DefaultProperty.instance.colors.blackTransparent,
                                    blurRadius: 40
                                  )
                                ] : []
                              ),
                            )
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: DefaultProperty.instance.sizes.itemViewHeight
                  ),
                  width: constraint.maxWidth,
                  height: DefaultProperty.instance.sizes.itemWidgetHeight -
                      DefaultProperty.instance.sizes.itemViewHeight,
                  child: Container(
                    margin: EdgeInsets.all(DefaultProperty.instance.spacing.sideMargins),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.itemModel.currency + " "+ widget.itemModel.price.toString(),
                              style: TextStyle(fontSize: 21),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: DefaultProperty.instance.spacing.sideMargins
                              ),
                              child: Text(widget.itemModel.name),
                            ),
                          ],
                        ),
                        Text(widget.itemModel.address),
                        Container(
                          margin: EdgeInsets.only(top: DefaultProperty.instance.spacing.sideMargins),
                          child: Row(
                            children: List.generate(
                              min(widget.itemModel.features.length+1, DefaultProperty.instance.limits.featuresCap+1) ,
                              (index){
                                if(index==0){
                                  return Text("Features: ");
                                }
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: DefaultProperty.instance.spacing.sideMargins
                                  ),
                                  child: Text(widget.itemModel.features[index-1]),
                                );
                              }
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.only(
                    left: constraint.maxWidth -
                      DefaultProperty.instance.sizes.locationButtonSize -
                      DefaultProperty.instance.spacing.sideMargins,
                    right: DefaultProperty.instance.spacing.sideMargins,
                    top: DefaultProperty.instance.sizes.itemViewHeight -
                      DefaultProperty.instance.sizes.locationButtonSize / 2
                  ),
                  width: DefaultProperty.instance.sizes.locationButtonSize,
                  height: DefaultProperty.instance.sizes.locationButtonSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DefaultProperty.instance.colors.mainIndigo,
                  ),
                  child: IconButton(
                    icon: Icon(
                        color: Colors.white,
                        Icons.location_on
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => MapDisplay( itemModel: widget.itemModel)
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
