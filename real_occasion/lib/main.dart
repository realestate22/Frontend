import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:real_occasion/services/cloud.dart';
import 'fire_base_auth.dart';
import 'fire_base_notification.dart';
import 'fire_base_real_db.dart';
import 'fire_base_storage.dart';
import 'google_map_show.dart';
import 'in_app_purchase.dart';

Future<void> _backgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print("Message being handled ${message.messageId}");
}



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.messageId);
  });
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_){
            return FireBaseClient();
          })
        ],
        child: MyApp()
      ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: FutureBuilder(
        future: context.read<FireBaseClient>().configureNotification(),
        builder: (context, snapshot){
          return PageView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return <Widget>[
                  FireBaseAuth(),
                  FireBaseStorage(),
                  FireBaseRealDB(),
                  GoogleMapShow(),
                  FireBaseNotification(),
                  InAppPurchase(),
                ].map((e){
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      )
                    ),
                    child: e,
                  );
                }).toList()[index];
              }
          );
        },
      )
    );
  }
}
