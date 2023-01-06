import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate_v02/widgets/default_property.dart';

import '../models/city_model.dart';
import '../models/item_model.dart';
import '../models/tag_model.dart';
import 'internet_connection.dart';

enum DataChange{
  Insert,
  Update,
  Delete,
}

class FirebaseRTDB extends ChangeNotifier{
  static int count = 0;

  static FirebaseRTDB? _firebaseRtdb;
  static FirebaseRTDB get instance =>
      _firebaseRtdb ??= FirebaseRTDB._private();

  static void destroy(){
    _firebaseRtdb = null;
  }



  FirebaseDatabase? _firebaseDatabase;
  Map<String,List<dynamic>> dummyData={};

  FirebaseRTDB._private(){
    //log("instantiated "+InternetConnection.instance.isConnected.toString());
    if(InternetConnection.instance.isConnected){
      _firebaseDatabase = FirebaseDatabase.instance;
    }
    InternetConnection.instance.connectivityStream.listen((event) {
      bool connected = (
          event==ConnectivityResult.mobile
              || event==ConnectivityResult.wifi
      );
      if(connected){
        _firebaseDatabase = FirebaseDatabase.instance;
      }else{
        _firebaseDatabase = null;
      }
    });
    //log("FirebaseRTDB: $_firebaseDatabase");
  }

  addData(MapEntry<String,dynamic> data){
    if(dummyData.containsKey(data.key)){
      dummyData[data.key]?.add(data.value);
    }else{
      dummyData.putIfAbsent(data.key, () => [data.value]);
    }
  }
  setUpDummyData() async{
    addData(
      MapEntry(
        "cities",
        CityModel(
          city: {
            "id": "1",
            "name": "Shkoder",
          }
        )
      )
    );

    addData(
      MapEntry(
        "tags",
        TagModel(
          tag:{
            "id": "1",
            "name":"closed"
          }
        )
      )
    );


    addData(
      MapEntry(
        "tags",
        TagModel(
          tag:{
            "id": "1",
            "name":"closed"
          }
        )
      )
    );

    addData(
      MapEntry(
        "tags",
        TagModel(
          tag:{
            "id": "2",
            "name":"lit"
          }
        )
      )
    );
    addData(
      MapEntry(
        "tags",
        TagModel(
          tag:{
            "id": "3",
            "name":"lake-view"
          }
        )
      )
    );


    addData(
      MapEntry(
        "items",
        ItemModel(
          id: "a1",
          active: true,
          address: "address",
          author: "author",
          wallpaper: DefaultProperty.instance.strings.serverLink+
              DefaultProperty.instance.strings.imagesServerLink +
              "RDC02DY4CuLkD9f.jpg",
          currency: "currency",
          expired: false,
          photo_gallery: [
            DefaultProperty.instance.strings.serverLink+
              DefaultProperty.instance.strings.imagesServerLink +
              "9z0kFh6yYVoFxi7.jpg"
          ],
          video_gallery: [
            DefaultProperty.instance.strings.serverLink+
                DefaultProperty.instance.strings.videosServerLink +
                "A1afZ5eyny0ttK3.mp4",
          ],
          longitude: 19.814799,
          latitude: 41.326422,
          description: "Lorem Ipsum",
          name: "name",
          type: "type",
          price: 4333,
          bookmarked: true,
          tags: [(dummyData["tags"]![2] as TagModel).tag, (dummyData["tags"]![0] as TagModel).tag],
          features: ["f1", "f2"],
          city: (dummyData["cities"]![0] as CityModel).city
        )
      )
    );

    addData(
      MapEntry(
        "items",
        ItemModel(
            id: "a2",
            active: true,
            address: "Pasko Vasha",
            author: "arlind",
            wallpaper: DefaultProperty.instance.strings.serverLink+
                DefaultProperty.instance.strings.imagesServerLink +
                "9z0kFh6yYVoFxi7.jpg",
            currency: "ALL",
            expired: false,
            photo_gallery: [
              DefaultProperty.instance.strings.serverLink+
                DefaultProperty.instance.strings.imagesServerLink +
                "gwCT7CxkwhQilAv.jpg",
              DefaultProperty.instance.strings.serverLink+
                DefaultProperty.instance.strings.imagesServerLink +
                "RDC02DY4CuLkD9f.jpg"],
            video_gallery: [
              DefaultProperty.instance.strings.serverLink+
                DefaultProperty.instance.strings.videosServerLink +
                "A1afZ5eyny0ttK3.mp4",
              DefaultProperty.instance.strings.serverLink+
                DefaultProperty.instance.strings.videosServerLink +
                "A1afZ5eyny0ttK3.mp4"
            ],
            longitude: 19.504306,
            latitude: 42.057842,
            description: "Lorem Ipsum",
            name: "Apartament",
            type: "3 Katesh",
            price: 4333,
            bookmarked: false,
            tags: [(dummyData["tags"]![0] as TagModel).tag,(dummyData["tags"]![1] as TagModel).tag],
            features: ["wifi", "parking"],
            city: (dummyData["cities"]![0] as CityModel).city
        )
      )
    );

    addData(
      MapEntry(
        "items",
        ItemModel(
            id: "a3",
            active: true,
            address: "Lagje Sami Frasheri",
            author: "erdi",
            // wallpaper: DefaultProperty.instance.strings.serverLink+
            //   DefaultProperty.instance.strings.imagesServerLink +
            //   "gwCT7CxkwhQilAv.jpg",
            wallpaper: "https://i.picsum.photos/id/701/600/300.jpg?hmac=MvZv1WvD_k1q2_xIUIBjwREjlq3XK8iMirkKaqLh8zg",
            currency: "ALL",
            expired: false,
            photo_gallery: [
              DefaultProperty.instance.strings.serverLink+
                DefaultProperty.instance.strings.imagesServerLink +
                "gwCT7CxkwhQilAv.jpg",
              DefaultProperty.instance.strings.serverLink+
                DefaultProperty.instance.strings.imagesServerLink +
                "RDC02DY4CuLkD9f.jpg"
            ],
            video_gallery: [
              DefaultProperty.instance.strings.serverLink+
                DefaultProperty.instance.strings.videosServerLink +
                "A1afZ5eyny0ttK3.mp4",
              DefaultProperty.instance.strings.serverLink+
                DefaultProperty.instance.strings.videosServerLink +
                "A1afZ5eyny0ttK3.mp4"
            ],
            longitude: 19.512393,
            latitude: 42.060217,
            description: "Dolor sit amet",
            name: "Hotel",
            type: "2 Dhome",
            price: 300,
            bookmarked: false,
            tags: [(dummyData["tags"]![1] as TagModel).tag,(dummyData["tags"]![2] as TagModel).tag],
            features: ["wifi", "parking"],
            city: (dummyData["cities"]![0] as CityModel).city
        )
      )
    );

  }

  Future modifyData({
    required String ref,
    required String keyOfId,
    required String id,
    required DataChange dataChange,
    Map<String, dynamic>? data
  }) async{
    if(_firebaseDatabase == null){
      return null;
    }
    DatabaseReference dbf = _firebaseDatabase!.ref(ref);
    log("${dbf.key}");
    DataSnapshot? userSnap;
    for(DataSnapshot child in (await dbf.get()).children){
      if(child.child(keyOfId).value==id){
        userSnap=child;
        break;
      }
    }
    log("${userSnap?.key} : ${userSnap?.value}");
    if(dataChange == DataChange.Insert){
      if(userSnap == null){
        dbf.push().set({
          keyOfId:id,
          ...?data
        });
      }else{
        return Future.error({1:"There is already a data insert as this id"});
      }
    }else if(dataChange == DataChange.Update || dataChange == DataChange.Delete){
      if(dataChange == DataChange.Update){
        if(userSnap == null){
          return Future.error({2:"There is no data with this id to update"});
        }else{
          if(userSnap.value.toString() != {keyOfId: id,...?data}.toString()) {
            dbf.child(userSnap.key!).set({
              keyOfId: id,
              ...?data
            });
          }else{
            log("new data and old data is the same no need for update");
          }
        }
      }else{
        if(userSnap == null){
          return Future.error({3:"There is no data with this id to delete"});
        }else{
          dbf.child(userSnap.key!).remove();
        }
      }
    }else{
      return Future.error({4:"No data changed"});
    }
  }

  Future gatherData({
    bool listenable = false,
    required String ref,
    required String keyOfId,
    required String id,
  }) async{
    if(_firebaseDatabase == null){
      return Future.error({0: "There is no internet connection"});
    }

    //count++;
    DatabaseReference dbf = _firebaseDatabase!.ref(ref);
    DataSnapshot? userSnap;

    for(DataSnapshot child in (await dbf.get()).children){
      if(child.child(keyOfId).value==id){
        userSnap=child;
        break;
      }
    }
    dbf.get().then((value){
      for(DataSnapshot child in value.children){
        if(child.child(keyOfId).value==id){
          userSnap=child;
          break;
        }
      }
    });

    if(userSnap==null){
      return Future.error({5: "There is no data with this id to get data from"});
    }
    if(listenable){
      Stream<DatabaseEvent> temp = dbf.child(userSnap!.key!).onValue;
      Future<Stream<DatabaseEvent>> fTemp= Future(() => temp);
      //fTemp.then((value) => log("Listening: $value =========== ${value.runtimeType}"));
      return fTemp;
    }else{
      Future<DataSnapshot> temp= dbf.child(userSnap!.key!).get();
      Future<Future<DataSnapshot>> fTemp= Future(() => temp);
      //fTemp.then((value) => log("Not Listening: $value =========== ${value.runtimeType}"));
      return fTemp;
    }
  }

}