import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationButton extends StatefulWidget {
  double longitude;
  double latitude;
  LocationButton({required this.longitude,required this.latitude});

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5,
                blurRadius: 5,
                //offset: const Offset(),
              )
            ]
        ),
        child: IconButton(
          color: Colors.blue,
          icon: const Icon(Icons.location_on),
          onPressed: (){
            //open google maps in certain position
            List<double> longSplit = getDegMinSec(widget.longitude);
            List<double> latSplit = getDegMinSec(widget.latitude);
            print("Maps opened in: longitude(${widget.longitude}) ,latitude(${widget.latitude})");

            String urn="https://www.google.com/maps/place/"
                "${latSplit[0].toInt()}%C2%B0"
                "${latSplit[1].toInt()}'"
                "${latSplit[2]}%22N+"
                "${longSplit[0].toInt()}%C2%B0"
                "${longSplit[1].toInt()}'"
                "${longSplit[2]}%22E";
            _launchUrl(urn);
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,

        )
    );
  }

  Future<void> _launchUrl(String urn) async {
    Uri url=Uri.parse(urn);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
  List<double> getDegMinSec(double input){
    List<double> res=List.filled(3, 0);
    res[0]=input.floorToDouble();
    input=(input-input.floorToDouble())*60;
    res[1]=input.floorToDouble();
    input=(input-input.floorToDouble())*60;
    input=(input*10).roundToDouble()/10;
    res[2]=input;
    return res;
  }
}
