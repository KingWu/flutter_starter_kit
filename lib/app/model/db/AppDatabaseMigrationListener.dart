import 'package:flutter_starter_kit/utility/db/DatabaseHelper.dart';
import 'package:flutter_starter_kit/utility/log/Log.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseMigrationListener implements DatabaseMigrationListener{

  static const int VERSION_1_0_0 = 1;

  @override
  void onCreate(Database db, int version) async {

      Log.info('onCreate version : $version');
      await _createDatabase(db, version);
  }

  @override
  void onUpgrade(Database db, int oldVersion, int newVersion) {
      Log.info('oldVersion : $oldVersion');
      Log.info('newVersion : $newVersion');
  }

  Future<void> _createDatabase(Database db, int version) async{
    if(VERSION_1_0_0 == version){
      await db.execute('CREATE TABLE AppContent (trackId INTEGER PRIMARY KEY, _order INTEGER, isFeatureApp INTEGER, '
          'isFreeApp INTEGER, trackName TEXT, description TEXT, meta TEXT)');
    }
  }
}