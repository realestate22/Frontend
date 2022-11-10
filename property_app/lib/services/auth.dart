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



}