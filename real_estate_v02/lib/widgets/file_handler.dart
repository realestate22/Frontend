import 'dart:developer' as dev;
import 'dart:math';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_v02/widgets/default_property.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'error_container.dart';

enum FileType{
  image,
  video,
  other,
}

enum FileFrom{
  encrypted,
  link,
  asset,
  file,
}

class FileHandler extends StatefulWidget {
  FileType? fileType;
  FileFrom? fileFrom;//link
  String value;
  double? width;
  double? height;
  BoxFit boxFit;
  FileHandler(
    this.value,{
    this.fileType,
    this.fileFrom,
    this.width,
    this.height,
    this.boxFit=BoxFit.contain,
  }) {
    findFileFromIfNull();
    findFileTypeIfNull();
    dev.log("File type: $fileType, File from: $fileFrom");

  }
  void findFileFromIfNull() {
    if(fileFrom==null){
      try{
        base64.decode(value);
        fileFrom=FileFrom.encrypted;
      }catch(e){
        if(value.contains("http")){
          fileFrom=FileFrom.link;
        }else{
          fileFrom=FileFrom.file;
        }
      }
    }
  }
  void findFileTypeIfNull() {
    if(fileType==null){
      switch(fileFrom){
        case FileFrom.link:
        case FileFrom.asset:
        case FileFrom.file:
          findFileTypeIfNullFromLinkAssetFile();
          break;
        case FileFrom.encrypted:
          findFileTypeIfNullFromEncrypted();
          break;
        default:
          break;
      }
    }
  }

  void findFileTypeIfNullFromLinkAssetFile() {
    switch(DefaultProperty.instance.strings.getTypeFromExtension(
        DefaultProperty.instance.strings.getExtensionsFromList(value)
    )){
      case "images":
        fileType=FileType.image;
        break;
      case "videos":
        fileType=FileType.video;
        break;
      case "other":
        fileType=FileType.other;
        break;
      default:
        break;
    }
  }
  void findFileTypeIfNullFromEncrypted() {
    const int maxImageSize= 50000000;
    try {
      int length=base64Decode(value).length;
      if(length<maxImageSize){
        fileType=FileType.image;
      }else{
        fileType=FileType.video;
      }
    }catch(e){
        fileType=FileType.video;
    }
  }

  @override
  State<FileHandler> createState() => _FileHandlerState();




}

class _FileHandlerState extends State<FileHandler> {

  bool _isPlaying = false;
  bool _showIcon = false;
  VideoPlayerController? vpc;
  CachedVideoPlayerController? cvpc;
  Image? image;
  CachedNetworkImage? cni;
  @override
  void dispose() {
    if(vpc!=null) {
      vpc!.dispose();
      vpc == null;
    }
    if(cvpc!=null) {
      cvpc!.dispose();
      cvpc == null;
    }
    if(image!=null) {
      image == null;
    }
    if(cni!=null) {
      cni == null;
    }
    super.dispose();
  }

  @override
  void initState() {
    try {
      if (widget.fileType != null && widget.fileFrom != null) {
        if (widget.fileFrom == FileFrom.link &&
            widget.fileType == FileType.image) { // image from link
          cni = CachedNetworkImage(
            imageUrl: widget.value,
            width: widget.width,
            height: widget.height,
            fit: widget.boxFit,
            key: UniqueKey(),
            progressIndicatorBuilder: (context, url, progress) {
              return Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              );
            },
            errorWidget: (context, url, error) {
              return const ErrorContainer();
            },
          );
        }
        else if (widget.fileFrom == FileFrom.link &&
            widget.fileType == FileType.video) { // video from link
          cvpc = CachedVideoPlayerController.network(
              widget.value
          );
        } else if (widget.fileFrom == FileFrom.asset &&
            widget.fileType == FileType.image) { //image from asset
          image = Image.asset(
            widget.value,
            width: widget.width,
            height: widget.height,
            fit: widget.boxFit,
          );
        } else if (widget.fileFrom == FileFrom.asset &&
            widget.fileType == FileType.video) { //video from asset
          vpc = VideoPlayerController.asset(
              widget.value
          );
        } else if (widget.fileFrom == FileFrom.file &&
            widget.fileType == FileType.image) { //image from file
          image = Image.file(
            File(widget.value),
            width: widget.width,
            height: widget.height,
            fit: widget.boxFit,
          );
        } else if (widget.fileFrom == FileFrom.file &&
            widget.fileType == FileType.video) { //video from file
          vpc = VideoPlayerController.file(
              File(widget.value)
          );
        } else if (widget.fileFrom == FileFrom.encrypted &&
            widget.fileType == FileType.image) { //image from base64
          image = Image.memory(
            base64Decode(widget.value),
            width: widget.width,
            height: widget.height,
            fit: widget.boxFit,
          );
        } else if (widget.fileFrom == FileFrom.encrypted &&
            widget.fileType == FileType.video) { //video from base64
          File newFile = File(
              "/storage/emulated/0/Download/${List.generate(20, (index) {
                return DefaultProperty.instance.strings.allowedCharsForFiles[
                Random().nextInt(
                    DefaultProperty.instance.strings.allowedCharsForFiles.length
                )
                ];
              }).join()}.mp4"
          );
          newFile.writeAsBytesSync(base64Decode(widget.value));
          vpc = VideoPlayerController.file(
              newFile
          );
        }

        if (widget.fileType == FileType.video) {
          if (vpc != null) {
            vpc!.initialize().then((_) {
              setState(() {});
            }).onError((error, stackTrace) {
              dev.log(error.toString());
            });
          } else if (cvpc != null) {
            cvpc!.initialize().then((_) {
              setState(() {});
            }).onError((error, stackTrace) {
              dev.log(error.toString());
            });
          }
        }
      }
    }catch(e){
      dev.log(e.toString());
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    try{


    if(widget.fileFrom!=null && widget.fileType!=null)
    {
      if(widget.fileType==FileType.image){
        if(image!=null){
          return image!;
        }
        else if(cni!=null){
          return cni!;
        }
      }
      else if(widget.fileType==FileType.video){
        if(vpc!=null) {
          return GestureDetector(
            onTap: () {
              setState(() {
                dev.log("happened");
                if (_isPlaying) {
                  vpc!.pause();
                } else {
                  vpc!.play();
                }

                _isPlaying = !_isPlaying;
                _showIcon = true;

                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    _showIcon = false;
                  });
                });
              });
            },
            child: Stack(
              children: [
                  SizedBox.expand(
                    child: FittedBox(
                      fit: widget.boxFit,
                      child: SizedBox(
                        width: vpc!.value.size.width,
                        height: vpc!.value.size.height,
                        child: VideoPlayer(vpc!),
                      ),
                    ),
                  ),
                if (_showIcon)
                  Center(
                    child: _isPlaying
                        ? const Icon(
                      Icons.play_arrow,
                      size: 32,
                      color: Colors.white,
                    )
                        : const Icon(
                      Icons.pause,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          );
        }else if(cvpc!=null){

          return GestureDetector(
            onTap: () {
              dev.log("happened");
              setState(() {
                if (_isPlaying) {
                  cvpc!.pause();
                } else {
                  cvpc!.play();
                }

                _isPlaying = !_isPlaying;
                _showIcon = true;

                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    _showIcon = false;
                  });
                });
              });
            },
            child: Stack(
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: widget.boxFit,
                    child: SizedBox(
                      width: cvpc!.value.size.width,
                      height: cvpc!.value.size.height,
                      child: CachedVideoPlayer(cvpc!),
                    ),
                  ),
                ),

                if (_showIcon)
                  Center(
                    child: _isPlaying
                        ? const Icon(
                      Icons.play_arrow,
                      size: 32,
                      color: Colors.white,
                    )
                        : const Icon(
                      Icons.pause,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          );
        }

      }
    }
    return const ErrorContainer();
    }catch(e){
      return const ErrorContainer();
    }
  }
}
