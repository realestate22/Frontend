import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_v02/widgets/default_property.dart';
import 'package:real_estate_v02/widgets/file_handler.dart';

import '../../services/cache_manager.dart';
import '../error_container.dart';

class GalleryScrollViewer extends StatefulWidget {
  List<String> gallery;

  int actualPage = 0;

  GalleryScrollViewer({
    required this.gallery
  }){

  }

  @override
  State<GalleryScrollViewer> createState() => _GalleryScrollViewerState();
}

class _GalleryScrollViewerState extends State<GalleryScrollViewer> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Stack(
          children: [
            PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  widget.actualPage = value;
                });
              },
              itemCount: widget.gallery.length,
              itemBuilder: (context, index) {
                log(widget.gallery[index]);
                return FileHandler(
                  widget.gallery[index],
                  width: constraint.maxWidth,
                  height: constraint.maxHeight,
                  boxFit: BoxFit.cover,
                );
              }
            ),
            Container(
              height: DefaultProperty.instance.sizes.indexViewSize,
              margin: EdgeInsets.only(
                  top: DefaultProperty.instance.sizes.itemViewHeight -
                      DefaultProperty.instance.spacing.sideMargins / 2 -
                      DefaultProperty.instance.sizes.indexViewSize
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.gallery.length,
                  (indexPos) {
                    return Container(
                      width: DefaultProperty.instance.sizes.indexViewSize,
                      height: DefaultProperty.instance.sizes.indexViewSize,
                      margin: EdgeInsets.only(
                          right: DefaultProperty.instance.sizes.indexViewSize/4,
                          left: DefaultProperty.instance.sizes.indexViewSize/4
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.actualPage==indexPos ? Colors.white : Colors.grey,
                      ),
                    );
                  }
                ),
              ),
            )
          ]
        );
      },
    );
  }
}
