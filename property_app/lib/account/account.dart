import 'package:flutter/material.dart';
import 'package:property_app/services/auth.dart';
import 'fire_button.dart';

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
                  FireButton(
                    width: 250,
                    label: "Sign in Anonymously",
                    foregroundColor: Colors.grey,
                    foregroundGradient : LinearGradient(colors: [
                      Colors.lightBlueAccent, Colors.red, Colors.amber, Colors.green
                    ]),
                    backgroundColor: Colors.white,
                    roundedSize: 20.0,
                    iconType: Icons.person_pin,
                    function: () async {
                      print("pressed");
                      dynamic result = await widget._auth.signAnonymously();
                      if (result == null) {
                        print("Error");
                      } else {
                        print("Signed up");
                        print(result);
                        print("");
                        print(await widget._auth.getId());
                      }
                    },
                  ),
                  FireButton(
                    width: 250,
                    label: "Sign in with Email",
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.white,
                    roundedSize: 20.0,
                    iconType: Icons.mail,
                    function: () async {
                      widget._auth.signEmail();
                    },
                  ),
                  FireButton(
                    width: 250,
                    label: "Sign in with Gmail",
                    foregroundColor: Colors.lightBlueAccent,
                    backgroundColor: Colors.white,
                    roundedSize: 20.0,
                    iconType: Icons.g_mobiledata,
                    function: () async {
                      widget._auth.signGmail();
                    },
                  ),
                  FireButton(
                    width: 250,
                    label: "Logout",
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    roundedSize: 20.0,
                    iconType: Icons.exit_to_app,
                    function: () async {
                      dynamic result=await widget._auth.signOut();
                      if (result == null) {
                        print("Error");
                      } else {
                        print("Signed out");
                        print(result);
                      }
                    },
                  ),
                ],
              ),
            ),//Sign in(annon/wG/wE)/register(wE)/logout
          ],
        ),
      ),
    );
  }
}
