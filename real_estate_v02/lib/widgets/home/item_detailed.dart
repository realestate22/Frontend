import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:real_estate_v02/models/item_model.dart';
import 'package:real_estate_v02/widgets/home/gallery_scroll_viewer.dart';

import '../default_property.dart';
import 'gallery_scroll_viewer_detailed.dart';

class ItemDetailed extends StatelessWidget {
  ItemModel itemModel;
  GalleryScrollViewer gsv;
  UniqueKey tag;
  ItemDetailed({required this.itemModel, required this.gsv, required this.tag}) {
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint){
        return Scaffold(
          body: Column(
            children: [
              Hero(
                tag: tag,
                child: Container(
                  width: constraint.maxWidth,
                  height: DefaultProperty.instance.sizes.itemViewDetailedHeight,
                  child: GalleryScrollViewerDetailed(
                    gallery: [
                      itemModel.wallpaper,
                      ...itemModel.photo_gallery,
                    ],
                    videoGallery: itemModel.video_gallery,
                    initialPage: gsv.actualPage,
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
