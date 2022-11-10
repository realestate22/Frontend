import 'package:flutter/material.dart';
import 'package:property_app/services/auth.dart';
class Account extends StatefulWidget {

  VoidCallback? refresh;
  AuthenticationService _auth= AuthenticationService();
  Account({this.refresh}){

  }

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Container(
        child: Column(
          children: [
            Container(),//Available when signed in
            Container(
              child: Column(
                children:[
                  Container(
                    padding: EdgeInsets.all(15),
                    child: TextButton.icon(
                      onPressed: () async{
                        print("pressed");
                        dynamic result= await widget._auth.signAnonymously();
                        if(result==null){
                          print("Error");
                        }else{
                          print("Signed up");
                          print(result);
                        }
                      },
                      icon: Icon(
                        Icons.hub,
                        color: Colors.lightBlueAccent,
                      ),
                      label: Text(
                        "Sign In Anoymously",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                          )
                        )
                      ),
                    ),
                  )
                ]
              ),
            ),//Sign in(annon/wG/wE)/register(wE)/logout
          ],
        ),
      )
    );
  }
}
