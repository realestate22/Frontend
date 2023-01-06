import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:real_estate_v02/models/item_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:real_estate_v02/widgets/default_property.dart';

class MapDisplay extends StatefulWidget {
  ItemModel itemModel;
  MapDisplay({required this.itemModel}) {

  }

  @override
  State<MapDisplay> createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {

  @override
  void dispose() {
    container=null;
    super.dispose();
  }
  @override
  void initState() {
    //getUserCurrentLocation();
  }
  Container? container;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder:(context, constraint){
          return FutureBuilder(
            future: getUserCurrentLocation(),
            builder: (context, snapshot) {
              List<Marker> markers = [];

              if(snapshot.hasData){
                markers.add(
                  Marker(
                    markerId: MarkerId("curr_pos"),
                    position: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                    infoWindow: InfoWindow(
                      title: "Current Location",
                    ),
                    onTap: (){
                      setState(() {
                        container = Container(
                          margin: EdgeInsets.only(
                              top: constraint.maxHeight -
                                  DefaultProperty.instance.sizes.mapDetailedHeight
                          ),
                          height: constraint.maxHeight ,
                          width: constraint.maxWidth,
                          color: Colors.white,
                        );
                      });
                    },
                    onDragStart: (value) {
                      log(value.toString());
                    },
                    draggable: true,
                    onDragEnd: (value) {
                      log(value.toString());
                    },

                  )
                );
              }


              markers.add(
                Marker(
                  markerId: MarkerId("placeTo"),
                  position: LatLng(widget.itemModel.latitude, widget.itemModel.longitude),
                  infoWindow: InfoWindow(
                    title: widget.itemModel.name,
                    snippet: widget.itemModel.type,
                  ),
                  onTap: (){
                    setState(() {
                      container = Container(
                        margin: EdgeInsets.only(
                            top: constraint.maxHeight -
                                DefaultProperty.instance.sizes.mapDetailedHeight
                        ),
                        height: constraint.maxHeight ,
                        width: constraint.maxWidth,
                        color: Colors.white,
                        child: TextButton(
                          onPressed: () {
                            log("06933242");
                          },
                          child: Container(),
                        )
                      );
                    });
                  },
                )
              );
              return Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.itemModel.latitude, widget.itemModel.longitude),
                      zoom: 15,
                    ),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    onMapCreated: (GoogleMapController controller){
                      //_controller.complete(controller);
                    },
                    onTap: (argument) {
                      setState(() {
                        container = null;
                      });
                    },
                    mapToolbarEnabled: true,
                    markers: Set<Marker>.of(markers),
                  ),
                  if(container != null) container!
                ]
              );
            },
          );
        }
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){})
    .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      log(error.toString());
    });
    Position pos=await Geolocator.getCurrentPosition();
    return pos;
  }

}
