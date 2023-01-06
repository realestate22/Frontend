import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'internet_connection.dart';

class FirebaseAuthUser extends ChangeNotifier{

  static FirebaseAuthUser? _firebaseAuthUser;
  static FirebaseAuthUser get instance =>
      _firebaseAuthUser ??= FirebaseAuthUser._private();

  static void destroy(){
    _firebaseAuthUser=null;
  }

  FirebaseAuth? _firebaseAuth;
  UserCredential? user;


  FirebaseAuthUser._private(){
    if(InternetConnection.instance.isConnected){
      _firebaseAuth = FirebaseAuth.instance;
    }

    InternetConnection.instance.connectivityStream.listen((event) {
      bool connected = (
          event==ConnectivityResult.mobile
              || event==ConnectivityResult.wifi
      );
      if(connected){
        _firebaseAuth = FirebaseAuth.instance;
      }else{
        _firebaseAuth = null;
      }
    });
  }

  Future logOut() async{
    if(_firebaseAuth==null){
      return null;
    }
    try{
      await _firebaseAuth!.signOut();
      user=null;
      notifyListeners();
    }catch(e){
      log(e.toString());
      return null;
    }
  }

  Future signInWithEmail(String email, String password) async{
    if(_firebaseAuth==null){
      return null;
    }
    try {
      UserCredential userCredential = await _firebaseAuth!.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      user=userCredential;
      //log("$user");
      notifyListeners();
      return userCredential.user;
    }catch(e){
      log(e.toString());
      return null;
    }
  }

  Future registerEmail(String email, String password) async{
    if(_firebaseAuth==null){
      return null;
    }
    try {
      UserCredential userCredential = await _firebaseAuth!.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      user=userCredential;
      notifyListeners();
      return userCredential.user;
    }catch(e){
      log(e.toString());
      return null;
    }
  }

  Future signInWithGoogle() async{
    if(_firebaseAuth==null){
      return null;
    }
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null){
        return null;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential= await _firebaseAuth!.signInWithCredential(googleCredential);
      user=userCredential;
      //log("$user");
      notifyListeners();
      return userCredential.user;
    }catch(e){
      log(e.toString());
      return null;
    }
  }
}