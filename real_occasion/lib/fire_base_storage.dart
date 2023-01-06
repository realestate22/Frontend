import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_occasion/file_handler.dart';
import 'package:real_occasion/services/cloud.dart';

class FireBaseStorage extends StatefulWidget {
  @override
  State<FireBaseStorage> createState() => _FireBaseStorageState();
}

class _FireBaseStorageState extends State<FireBaseStorage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              context.read<FireBaseClient>().getFilesFromPlatform(
                multiple: true,
                extensions: FileHandler.extensions,
              );
            },
            child: Text("Upload File"),
          ),
          Container(
            height: 150,
            child: ListView.builder(
              itemCount: context.watch<FireBaseClient>().actualFilesBeingSent!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  child: FileHandler(file: context.watch<FireBaseClient>().actualFilesBeingSent[index]!.values!.first!, size: 150),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<FireBaseClient>().
              uploadFilesToServer(urlUploadTo: "http://192.168.1.211:8000/uploadFiles.php");
            },
            child: const Text("Send"),
          )


        ],
      )



    );
  }
}
