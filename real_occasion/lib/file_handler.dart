import 'dart:io';
import 'package:flutter/material.dart';
import 'package:real_occasion/video_player.dart';
import 'package:tuple/tuple.dart';

class FileHandler extends StatefulWidget {

  static Map<String, List<String>> extensions={
    "images": ["jpeg","jpg","png","gif","ico"],
    "videos": ["mp4","mov"]
  };

  File file;
  String extension = '';
  int type = -1;//-1-other, 0-image, 1-video,
  double size;

  FileHandler({required this.file, required this.size}){
      extension = file.path.split("/").last.split(".").last;

      String sType = extensions.entries.firstWhere((e){
        return e.value.contains(extension);
        }, orElse: () => const MapEntry("other", [])
      ).key;
      type = extensions.entries.toList().indexWhere((element) => element.key==sType);
  }

  @override
  State<FileHandler> createState() => _FileHandlerState();
}

class _FileHandlerState extends State<FileHandler> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.type==0){
      return Container(
        decoration: BoxDecoration(color: Colors.black),
        height: widget.size,
        child: Image.file(widget.file),
      );
    }else if(widget.type==1) {
      return VideoPlayerWidget(
        input: widget.file,
        size: widget.size
      );
    }else{
      return Container();
    }
  }
}
