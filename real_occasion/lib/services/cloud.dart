import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseClient extends ChangeNotifier{

  late final FirebaseAuth _firebaseAuth;
  late final FirebaseDatabase _firebaseDatabase;
  late final FirebaseStorage _firebaseStorage;
  late final FirebaseMessaging _firebaseMessaging;

  UserCredential? _actualUser;
  List<Map<String,File>> _actualFilesBeingSent = [];
  List<String> _linksOfFiles = [];


  UserCredential? get actualUser => _actualUser;
  List<Map<String,File>> get actualFilesBeingSent=> _actualFilesBeingSent;
  List<String> get linkOfFiles => _linksOfFiles;

  FirebaseDatabase get firebaseDatabase => _firebaseDatabase;
  FirebaseMessaging get firebaseMessaging => _firebaseMessaging;

  FireBaseClient(){
    _firebaseAuth=FirebaseAuth.instance;
    _firebaseDatabase=FirebaseDatabase.instance;
    _firebaseStorage=FirebaseStorage.instance;
    _firebaseMessaging=FirebaseMessaging.instance;

  }

  // Future seeApps() async{
  //    print(await Firebase.apps);
  // }

  Future logOut() async{
    try{
      await _firebaseAuth.signOut();
      _actualUser=null;
      notifyListeners();
    }catch(e){
      print(e);
    }
  }

  Future signInWithEmail(String email, String password) async{
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print(userCredential);
      _actualUser=userCredential;
      notifyListeners();
      return userCredential.user;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future registerEmail(String email, String password) async{
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      _actualUser=userCredential;
      print(userCredential.user);
      notifyListeners();
      return userCredential.user;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future signInWithGoogle() async{
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null){
        return null;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      OAuthCredential googleCredential = await GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      UserCredential userCredential= await _firebaseAuth.signInWithCredential(googleCredential);
      print(userCredential.user);
      _actualUser=userCredential;

      notifyListeners();
      return userCredential.user;
    }catch(e){
      print(e);
      return null;
    }
  }


  Future uploadFilesToFirebaseServer({
    bool single = true,
    Map<String, List<String>>? extensions,
    int max = 0}) async{
    try {
      List<String>? combinedExt = extensions?.values.expand((element) => element).toList();
      print(combinedExt);
      FilePickerResult? res = await FilePicker.platform.pickFiles(
        allowMultiple: !single,
        type: FileType.custom,
        allowedExtensions: combinedExt,
      );
      if(res==null){
        print("No file was picked");
        return null;
      }

      if(single){
        PlatformFile file = res.files.single;
        String uploadTo = extensions?.entries.firstWhere(
          (e)=> e.value.contains(file.extension)
        ).key ?? "other";
        File inFile = File(file.path!);
        await _firebaseStorage.ref("$uploadTo/${file.name}").putFile(inFile);
      }else{
        List<PlatformFile> files=res.files;
        int until= max > 0 && max < files.length ? max : files.length;
        if(until!=max){ print("You can only upload $until files");}
        for(int i=0; i < until; i++){
          String uploadTo = extensions?.entries.firstWhere(
            (e)=> e.value.contains(files[i].extension)
          ).key ?? "other";
          File inFile = File(files[i].path!);

          await _firebaseStorage.ref("$uploadTo/${files[i].name}").putFile(inFile);
        }
      }
    }catch(e){
      print(e);
      return null;
    }
  }

  Future getFilesFromPlatform({
    bool multiple = false,
    Map<String, List<String>>? extensions,
    int max = 0
  }) async{
    try {
      _actualFilesBeingSent=[];
      _linksOfFiles=[];
      List<String>? combinedExt = extensions?.values.expand((element) => element).toList();
      print(combinedExt);
      FilePickerResult? res = await FilePicker.platform.pickFiles(
        allowMultiple: multiple,
        type: FileType.custom,
        allowedExtensions: combinedExt,
      );
      if(res==null){
        print("No file was picked");
        return null;
      }
      if(!multiple){
        PlatformFile pfile = res.files.single;
        String uploadTo = extensions?.entries.firstWhere(
                (e)=> e.value.contains(pfile.extension)
        ).key ?? "other";
        File file= File(pfile.path!);
        log(pfile.path!);

        _actualFilesBeingSent.add({uploadTo: file});

      }else{
        List<PlatformFile> files=res.files;
        int until= max > 0 && max < files.length ? max : files.length;
        if(max<files.length && max!=0){ print("You can only upload $until files");}

        for(int i=0; i < until; i++){
          String uploadTo = extensions?.entries.firstWhere(
                  (e)=> e.value.contains(files[i].extension)
          ).key ?? "other";
          log(files[i].path!);
          File file=new File(files[i].path!);

          _actualFilesBeingSent.add({uploadTo: file});
        }

      }
      notifyListeners();
      //uploadFilesToServer(urlUploadTo: "http://192.168.1.211:8000/uploadFiles.php");
      //
      //
    }catch(e){
      print(e);
      return null;
    }
  }

  Future uploadFilesToServer({ required String urlUploadTo}) async{
    try {
      for(Map<String, File> item in _actualFilesBeingSent) {
        MultipartFile mpFile= await MultipartFile.fromFile(item.values.first.path);
        FormData formData=FormData.fromMap({item.keys.first : mpFile});
        Response response = await Dio().post(urlUploadTo,
            data: formData
        );
        //if(response.data!=null||response.data==""){
        //}
        print("Response: ${response.data}");
        _linksOfFiles.add(response.data);
      }
      notifyListeners();
    }catch(e){
      print(e);
      return null;
    }
  }

  Future getNotification() async {
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();


  }

  Future configureNotification() async{
    NotificationSettings settings= await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
    );
    print(settings.authorizationStatus);
  }

  Future openInAppPurchase() async{

  }

  Future setGoogleMapView() async{

  }

}