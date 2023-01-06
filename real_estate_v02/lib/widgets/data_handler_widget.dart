import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../services/firebase_rtdb.dart';

class DataHandlerWidget extends StatelessWidget {
  String ref;
  String keyOfId;
  String id;
  bool listenable;


  DataHandlerWidget({
    required this.ref,
    required this.keyOfId,
    required this.id,
    required this.listenable
  }){}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseRTDB.instance.gatherData(
          ref: ref,
          keyOfId: keyOfId,
          id: id,
          listenable: listenable,
        ),
        builder: (context, snapshot){

          //dev.log("Count: ${FirebaseRTDB.count}");
          //dev.log("Type: ${snapshot.data.runtimeType}, $listenable");
          if(snapshot.hasData) {
            if (snapshot.data is! Future) {
              return StreamBuilder(
                stream: snapshot.data as Stream<DatabaseEvent>,
                builder: (context, snapshotStream) {
                  //dev.log("$snapshotStream");
                  if (snapshotStream.hasData) {
                    DatabaseEvent dbEvent = snapshotStream.data!;
                    String? data = dbEvent.snapshot.child("name").value.toString();
                    return Container(
                      child: Center(
                        child: Text(
                            data != null
                                ? (data.isNotEmpty ? data : "Null")
                                : "Null"
                        ),
                      ),
                    );
                  }
                  // showDialog(context: context, builder: (context) {
                  //   return SizedBox(
                  //     child: Center(
                  //       child: Text("${snapshot.error}"),
                  //     ),
                  //   );
                  // });
                  return Container(
                    child: Center(
                      child: Text(
                        "None",
                      ),
                    ),
                  );
                },
              );
            } else {
              return FutureBuilder(
                future: snapshot.data as Future<DataSnapshot>,
                builder: (context, snapshot) {
                  //dev.log("$snapshot");
                  if (snapshot.hasData) {
                    DataSnapshot dbEvent = snapshot.data as DataSnapshot;
                    String? data = dbEvent.child("name").value.toString();
                    return Container(
                      child: Center(
                        child: Text(
                            data != null
                                ? (data.isNotEmpty ? data : "Null")
                                : "Null"
                        ),
                      ),
                    );
                  }
                  // showDialog(context: context, builder: (context) {
                  //   return SizedBox(
                  //     child: Center(
                  //       child: Text("${snapshot.error}"),
                  //     ),
                  //   );
                  // });
                  return Container(
                    child: Center(
                      child: Text(
                        "None",
                      ),
                    ),
                  );
                },
              );
            }
          }

          // showDialog(context: context, builder: (ctx) {
          //   return AlertDialog(
          //     title: const Text("Error throun"),
          //     content: Text("${snapshot.error}"),
          //     actions: <Widget>[
          //       TextButton(
          //         onPressed: () {
          //           Navigator.of(ctx).pop();
          //         },
          //         child: Container(
          //           color: Colors.green,
          //           padding: const EdgeInsets.all(14),
          //           child: const Text("okay"),
          //         ),
          //       ),
          //     ],
          //   );
          // });
          return Container(
            child: Center(
              child: Text(
                "None",
              ),
            ),
          );
        }
    );
  }
}
