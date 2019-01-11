import 'dart:convert';

import 'package:flutter_starter_kit/app/model/pojo/AppContent.dart';
import 'package:flutter_starter_kit/app/model/pojo/Attribute.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_starter_kit/utility/log/Log.dart';

class DBAppStoreRepository{

  Database _database;

  DBAppStoreRepository(this._database);


  Future<void> saveOrUpdateFeatureApp(AppContent appContent) async{

    String meta = jsonEncode(appContent.toJson());
    int count = await _database.rawUpdate('UPDATE AppContent SET _order = ?, isFeatureApp = ? , trackName = ? , description = ? , meta = ?  WHERE trackId = ?', [appContent.order, appContent.isFeatureApp, appContent.trackName, appContent.description,  meta, appContent.trackId]);
    if(0 == count){
      await _database.rawInsert('INSERT INTO AppContent (trackId, _order, isFeatureApp, trackName, description, meta) VALUES (?, ?, ?, ?, ?, ?)',
          [appContent.trackId, appContent.order, appContent.isFeatureApp, appContent.trackName, appContent.description,  meta]);
    }
  }

  Future<void> saveOrUpdateTopFreeApp(AppContent appContent) async{

    String meta = jsonEncode(appContent.toJson());
    int count = await _database.rawUpdate('UPDATE AppContent SET _order = ?, isFreeApp = ? , trackName = ? , description = ? , meta = ?  WHERE trackId = ?', [appContent.order, appContent.isFeatureApp, appContent.trackName, appContent.description,  meta, appContent.trackId]);
    if(0 == count){
      await _database.rawInsert('INSERT INTO AppContent (trackId, _order, isFreeApp, trackName, description, meta) VALUES (?, ?, ?, ?, ?, ?)',
          [appContent.trackId, appContent.order, appContent.isFreeApp, appContent.trackName, appContent.description,  meta]);
    }
  }

  Future<void> saveOrUpdateDetailApp(AppContent appContent) async{
    String meta = jsonEncode(appContent.toJson());
    await _database.rawUpdate('UPDATE AppContent SET meta = ?  WHERE trackId = ?', [meta, appContent.trackId]);
  }

  Future<void> deleteAllAppContent() async{
    await _database.rawDelete('DELETE FROM AppContent');
  }



  Future<List<AppContent>> loadFeaturesApp(String searchKey) async{
    String searchSql = '';
    if(searchKey.isNotEmpty){
      searchSql = "AND (`trackName` LIKE '%$searchKey%' OR `description` LIKE '%$searchKey%')";
    }

    List<Map> list = await _database.rawQuery("SELECT  _order, meta FROM AppContent WHERE `isFeatureApp` = 1 $searchSql ORDER BY `_order` ASC");
    List<AppContent> applist = [];
    for(var map in list){
      AppContent appContent = AppContent.fromJson(jsonDecode(map['meta']));
      appContent.order = map['_order'];
      applist.add(appContent);
    }
    return applist;
  }

  Future<List<AppContent>> loadTopFreeApp(String searchKey) async{

    String searchSql = '';
    if(searchKey.isNotEmpty){
      searchSql = "AND (trackName LIKE '%$searchKey%' OR description LIKE '%$searchKey%')";
    }

    List<Map> list = await _database.rawQuery("SELECT  _order, meta FROM AppContent WHERE `isFreeApp` = 1 $searchSql ORDER BY `_order` ASC");
    List<AppContent> applist = [];

    for(var map in list){
      AppContent appContent = AppContent.fromJson(jsonDecode(map['meta']));
      appContent.order = map['_order'];
      applist.add(appContent);
    }
    return applist;
  }

  Future<AppContent> loadAppDetail(num trackId) async{
    List<Map> list = await _database.rawQuery("SELECT meta from AppContent WHERE trackId = $trackId LIMIT 1");
    if(list.length > 0){
      return AppContent.fromJson(jsonDecode(list[0]['meta']));
    }
    return null;
  }

}