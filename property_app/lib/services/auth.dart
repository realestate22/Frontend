import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{

  AuthenticationService(){}

  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future signAnonymously() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user= result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signEmail() async{

  }
  Future signGmail() async{

  }
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e);
      return null;
    }
  }


  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }





}