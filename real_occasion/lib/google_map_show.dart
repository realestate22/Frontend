import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'field_form_field.dart';

class GoogleMapShow extends StatefulWidget {

  @override
  State<GoogleMapShow> createState() => _GoogleMapShowState();
}

class _GoogleMapShowState extends State<GoogleMapShow> {
  GlobalKey<FormState> form= GlobalKey();
  FocusNode _longFN = FocusNode();
  TextEditingController _longTEC = TextEditingController();
  FocusNode _latFN = FocusNode();
  TextEditingController _latTEC = TextEditingController();
  FocusNode _search = FocusNode();

  double? longitude;
  double? latitude;

  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
        children: [
          Form(
            key: form,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FieldFormField(
                  width: 150,
                  type: "number",
                  label: "longitude",
                  currFN: _longFN,
                  currTEC: _longTEC,
                  nextFN: _latFN,
                ),
                FieldFormField(
                    width: 150,
                    type: "number",
                    label: "latitude",
                    currFN: _latFN,
                    currTEC: _latTEC,
                    nextFN: _search,
                ),
                TextButton(
                  onPressed: (){
                    if(form.currentState!.validate()){
                      _longFN.unfocus();
                      _latFN.unfocus();
                      _search.unfocus();

                      setState(() {
                        longitude=double.tryParse(_longTEC.text);
                        latitude=double.tryParse(_latTEC.text);
                      });

                    }
                  },
                  child: Text("Search")
                ),
              ],
            )
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              color: Colors.blue,
              child: Container()/*GoogleMap(
                initialCameraPosition:
                CameraPosition(
                  target: (latitude!=null&&longitude!=null)
                    ?LatLng(latitude!,longitude!)
                    :LatLng(42, 19.5),
                  zoom: 15,
                ),
                onMapCreated: (controller) {
                  mapController=controller;
                },
                markers: {
                  Marker(
                  markerId: MarkerId("Location"),
                  position: (latitude!=null&&longitude!=null)
                    ?LatLng(latitude!,longitude!)
                    :LatLng(42, 19.5),
                  infoWindow: InfoWindow(title: "Cool place", snippet: "nice")
                  ),
                },
              ),*/
            ),
          )
        ],
      )

    );
  }
}
