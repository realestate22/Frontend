import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerWidget extends StatefulWidget {
  int type;//0-File,1-Assets,2-Network
  dynamic input;//
  double size;
  VideoPlayerWidget({this.type = 0,required this.input, required this.size}){
    print({type: input});
  }

  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? vpc;

  @override
  void initState() {
    vpc = widget.type == 0
      ? VideoPlayerController.file(widget.input)
        : widget.type == 1
      ? VideoPlayerController.asset(widget.input)
        : widget.type == 2
      ? VideoPlayerController.network(widget.input)
        : null;
    vpc?..addListener(() {setState(() {});})
      ..setLooping(true)
      ..initialize().then((_) => vpc?.play());
  }

  @override
  void dispose() {
    vpc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(vpc!=null){
      return Container(
        height: widget.size,
        child: AspectRatio(
          aspectRatio: vpc!.value.aspectRatio,
          child: GestureDetector(

            onTap:() {
              if(vpc!.value.isInitialized){
                if(vpc!.value.isPlaying){
                  vpc!.pause();
                }else{
                  vpc!.play();
                }
              }
            },
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      child: VideoPlayer(vpc!),
                    )
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    color: Color.fromARGB(20, 12, 12, 12),
                      alignment: Alignment.center,
                      child: vpc!.value.isPlaying?
                      Icon(
                        Icons.pause,
                        color: Color.fromRGBO(200, 200, 200, 0.75),
                      ):
                      Icon(
                        Icons.play_arrow,
                        color: Color.fromRGBO(200, 200, 200, 0.75),
                      )
                  ),
                ),
              ],
            ),
          )
        )

      );
    }else{
      return Container(
        height: widget.size,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    //return Container();
  }
}
