import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:real_estate_v02/widgets/default_property.dart';
import 'package:real_estate_v02/widgets/file_handler.dart';

import '../../services/cache_manager.dart';
import '../error_container.dart';

class GalleryScrollViewerDetailed extends StatefulWidget {
  List<String> gallery;
  List<String> videoGallery;
  int actualPage = 0;
  int initialPage;
  GalleryScrollViewerDetailed({
    required this.gallery,
    required this.videoGallery,
    required this.initialPage
  }){
    actualPage = initialPage;
  }

  @override
  State<GalleryScrollViewerDetailed> createState() => _GalleryScrollViewerDetailedState();
}

class _GalleryScrollViewerDetailedState extends State<GalleryScrollViewerDetailed> {
  CacheManager customCacheManager = CacheManager(
      Config(
        "customCacheKey",
        stalePeriod: const Duration(days: 15),
        maxNrOfCacheObjects: 100,
      )
  );
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
                controller: PageController(
                  initialPage: widget.initialPage
                ),
                itemCount: widget.gallery.followedBy(widget.videoGallery).length,
                itemBuilder: (context, index) {
                  log(widget.gallery.followedBy(widget.videoGallery).toList()[index]);
                  return FileHandler(
                    widget.gallery.followedBy(widget.videoGallery).toList()[index],
                    width: constraint.maxWidth,
                    height: constraint.maxHeight,
                    boxFit: BoxFit.cover,
                  );
                }
            ),
            Container(
              height: DefaultProperty.instance.sizes.indexViewSize,
              margin: EdgeInsets.only(
                  top: DefaultProperty.instance.sizes.itemViewDetailedHeight -
                      DefaultProperty.instance.spacing.sideMargins / 2 -
                      DefaultProperty.instance.sizes.indexViewSize
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    widget.gallery.followedBy(widget.videoGallery).length,
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
