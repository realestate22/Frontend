import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
class PermissionHandler extends ChangeNotifier{
  static PermissionHandler? _permissionHandler;
  static PermissionHandler get instance=>
    _permissionHandler??=PermissionHandler._private();

  PermissionStatus? _permissionStatus;

  PermissionHandler._private(){

  }

  Future handlePermission ()async{
    try {
      _permissionStatus = await Permission.storage.status;

      if (_permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        _permissionStatus = permissionStatus;
        notifyListeners();
      }
    }catch(e){
      log("permission wasnt granted $e");
    }
  }


}