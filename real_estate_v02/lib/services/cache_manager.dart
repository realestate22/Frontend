import 'dart:convert';
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class FileCacheManager{

  static FileCacheManager? _fileCacheManager;
  static FileCacheManager get instance =>
    _fileCacheManager ??= FileCacheManager._private();

  late File cacheAccounts;
  late File cacheBookmarks;
  late File cacheItems;
  Map<String, dynamic>? cacheAccountsJson;
  Map<String, dynamic>? cacheBookmarksJson;
  Map<String, dynamic>? cacheItemsJson;
  String cacheAccountsJsonName="cache_account.json";
  String cacheBookmarksJsonName="cache_bookmarks.json";
  String cacheItemsJsonName= "cache_items.json";

  FileCacheManager._private(){
    writeToFileAccounts(true, "");
    writeToFileBookmarks(true, "");
    writeToFileItems(true, "");
  }

  Future writeToFileAccounts(bool toAppend, String contents) async{
    if(cacheAccounts==null){
      Directory saveTo = await getTemporaryDirectory();
      cacheAccounts=File("${saveTo.path}/$cacheAccountsJsonName");
    }
    await cacheAccounts!.writeAsString(
        contents,
        encoding: utf8,
        flush: true,
        mode: toAppend ? FileMode.append: FileMode.write
    );
    String insideFile = await cacheAccounts!.readAsString(encoding: utf8);
    if(insideFile.isNotEmpty){
      cacheAccountsJson = jsonDecode(insideFile);
    }
  }

  Future writeToFileBookmarks(bool toAppend, String contents) async{
    if(cacheBookmarks==null){
      Directory saveTo = await getTemporaryDirectory();
      cacheBookmarks=File("${saveTo.path}/$cacheBookmarksJsonName");
    }
    await cacheBookmarks!.writeAsString(
        contents,
        encoding: utf8,
        flush: true,
        mode: toAppend ? FileMode.append: FileMode.write
    );
    String insideFile = await cacheBookmarks!.readAsString(encoding: utf8);
    if(insideFile.isNotEmpty){
      cacheBookmarksJson = jsonDecode(insideFile);
    }
  }

  Future writeToFileItems(bool toAppend, String contents) async{
    if(cacheItems==null){
      Directory saveTo = await getTemporaryDirectory();
      cacheItems=File("${saveTo.path}/$cacheItemsJsonName");
    }
    await cacheItems!.writeAsString(
      contents,
      encoding: utf8,
      flush: true,
      mode: toAppend ? FileMode.append: FileMode.write
    );
    String insideFile = await cacheItems!.readAsString(encoding: utf8);
    if(insideFile.isNotEmpty){
      cacheItemsJson = jsonDecode(insideFile);
    }
  }
}