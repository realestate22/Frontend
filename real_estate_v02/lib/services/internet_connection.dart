import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection{
  static InternetConnection? _internetConnection;
  static InternetConnection get instance=>
      _internetConnection??=InternetConnection._private();

  late final Connectivity connectivity;
  late Stream<ConnectivityResult> connectivityStream;
  bool isConnected = false;

  InternetConnection._private(){
    connectivity = Connectivity();
    connectivity.checkConnectivity().then((value){
      isConnected = (value==ConnectivityResult.mobile
          || value==ConnectivityResult.wifi);
    });
    connectivityStream = connectivity.onConnectivityChanged.asBroadcastStream();
    connectivityStream.listen((event) {
      isConnected = (event==ConnectivityResult.mobile
          || event==ConnectivityResult.wifi);
      log("Connected: $isConnected");
    });
  }

}